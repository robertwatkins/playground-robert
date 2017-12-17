
import org.gephi.graph.api.*;
import org.gephi.io.exporter.api.ExportController;
import org.gephi.io.importer.api.Container;
import org.gephi.io.importer.api.EdgeDirectionDefault;
import org.gephi.io.importer.api.ImportController;
import org.gephi.io.importer.spi.FileImporter;
import org.gephi.io.processor.plugin.DefaultProcessor;
import org.gephi.layout.plugin.force.StepDisplacement;
import org.gephi.layout.plugin.force.yifanHu.YifanHuLayout;
import org.gephi.preview.api.PreviewController;
import org.gephi.preview.api.PreviewModel;
import org.gephi.preview.api.PreviewProperty;
import org.gephi.preview.types.DependantColor;
import org.gephi.preview.types.EdgeColor;
import org.gephi.project.api.ProjectController;
import org.gephi.project.api.Workspace;
import org.gephi.statistics.plugin.GraphDistance;
import org.openide.util.Lookup;

import java.awt.*;
import java.io.*;


public class WorkingSample {

    public static void main(String[] args)
    {
        System.out.println(System.getProperty("user.dir"));
        File graphmlFile = new File("src/main/resources/Sample.graphml");
        System.out.println("File size:"+graphmlFile.length());
        Workspace workspace = initializeGephiWorkspace();
        workspace = importGraphML(graphmlFile,workspace);
        processGraph(workspace);

        GraphModel graphModel = Lookup.getDefault().lookup(GraphController.class).getGraphModel(workspace);
        DirectedGraph directedGraph = graphModel.getDirectedGraph();
        //listEdges(directedGraph);
        //listNodes(directedGraph);
        String outputFilename="graph.pdf";
        exportGraphMLToFile(outputFilename);

    }

    private static void processGraph(Workspace workspace){
        //Get a graph model - it exists because we have a workspace
        GraphModel graphModel = Lookup.getDefault().lookup(GraphController.class).getGraphModel(workspace);
        DirectedGraph directedGraph = graphModel.getDirectedGraph();
        setLabelToDescription(directedGraph);

        setNodeColors(directedGraph);


    }

    private static void setNodeColors(DirectedGraph directedGraph) {
        for (Node node:directedGraph.getNodes()){
            //fix labels after import
            for (Column column:node.getAttributeColumns()){
                //System.out.println(column.getTitle()+":"+node.getAttribute(column));
                if (column.getTitle().equals("System") && node.getAttribute(column)!=null) {
                    String systemName = (String)node.getAttribute(column);
                    Color color;
                    switch (systemName){
                        case "none" :
                            color = Color.LIGHT_GRAY;
                            break;

                        case "Warehouse":
                            color = Color.CYAN; //Color.decode("0x000033");
                            break;

                        case "Inventory":
                            color = Color.MAGENTA; //Color.decode("0x003333");
                            break;

                        case "Portal":
                            color = Color.GREEN; //Color.decode("0x330033");
                            break;

                        case "Receiving":
                            color = Color.ORANGE; //Color.decode("0x330000");
                            break;

                        case "Accounting":
                            color = Color.BLUE; //Color.decode("0x333300");
                            break;

                        default:
                            color = Color.LIGHT_GRAY; //Color.decode("0x333333");
                    }
                    System.out.println("Setting "+node.getLabel()+ " to color '"+color+"'");
                    node.setColor(color);
                }
            }
        }
    }

    private static void setLabelToDescription(DirectedGraph directedGraph) {
        //the graphml import uses the 'role' as the label by default (not sure why, maybe that
        //can be fixed. This sets it to a desired value
        for (Node node:directedGraph.getNodes()){
            //fix labels after import
            for (Column column:node.getAttributeColumns()){
                if (column.getTitle().equals("description")) {
                    String newLabel = (String)node.getAttribute(column);
                    node.setLabel(newLabel);
                }
            }
        }

        //edges have their descriptions in custom field called 'd13'
        for (Edge edge:directedGraph.getEdges()){
            //fix labels after import
            for (Column column:edge.getAttributeColumns()){
                if (column.getTitle().equals("d13")) {
                    String newLabel = (String)edge.getAttribute(column);
                    edge.setLabel(newLabel);
                }
            }
        }

    }

    private static void listNodes(DirectedGraph directedGraph) {
        for (Node node:directedGraph.getNodes()){
            //fix labels after import
            for (Column column:node.getAttributeColumns()){
                if (column.getTitle().equals("description")) {
                    String newLabel = (String)node.getAttribute(column);
                    node.setLabel(newLabel);
                }
            }

            System.out.println("Node  label       = "+ node.getLabel());
            System.out.print("      attributes  = " );
            for (Column column:node.getAttributeColumns()){
                System.out.print("("+column.getTitle()+", "+node.getAttribute(column)+") ");
            }
            System.out.println();
            System.out.println("      id          = "+ node.getId());

        }
    }

    private static void listEdges(DirectedGraph directedGraph) {
        for (Edge edge:directedGraph.getEdges()) {

            System.out.println("Edge  label = " + edge.getLabel());
            System.out.println("      id    = " + edge.getId());
            for (Column column:edge.getAttributeColumns()){
                System.out.print("("+column.getTitle()+", "+edge.getAttribute(column)+") ");
            }
            System.out.println();

        }
    }

    private static Workspace initializeGephiWorkspace() {
        //Init a project - and therefore a workspace
        ProjectController pc = Lookup.getDefault().lookup(ProjectController.class);
        pc.newProject();
        pc.newWorkspace(pc.getCurrentProject());

        return pc.getCurrentWorkspace();
    }

    private static void exportGraphMLToFile(String outputFilename) {
        GraphModel graphModel = Lookup.getDefault().lookup(GraphController.class).getGraphModel();
        //Run YifanHuLayout for 100 passes - The layout always takes the current visible view
        YifanHuLayout layout = new YifanHuLayout(null, new StepDisplacement(1f));
        layout.setGraphModel(graphModel);
        layout.resetPropertiesValues();
        layout.setOptimalDistance(200f);

        layout.initAlgo();
        for (int i = 0; i < 100 && layout.canAlgo(); i++) {
            layout.goAlgo();
        }
        layout.endAlgo();

        //Get Centrality
        GraphDistance distance = new GraphDistance();
        distance.setDirected(true);
        distance.execute(graphModel);

        //Preview
        PreviewModel model = Lookup.getDefault().lookup(PreviewController.class).getModel();
        model.getProperties().putValue(PreviewProperty.SHOW_NODE_LABELS, Boolean.TRUE);
        model.getProperties().putValue(PreviewProperty.NODE_OPACITY, 100);
        model.getProperties().putValue(PreviewProperty.NODE_LABEL_FONT, model.getProperties().getFontValue(PreviewProperty.NODE_LABEL_FONT).deriveFont(8));
        model.getProperties().putValue(PreviewProperty.NODE_BORDER_WIDTH,50);
        model.getProperties().putValue(PreviewProperty.NODE_BORDER_COLOR, new DependantColor(Color.LIGHT_GRAY));

        model.getProperties().putValue(PreviewProperty.SHOW_EDGE_LABELS, Boolean.TRUE);
        model.getProperties().putValue(PreviewProperty.EDGE_CURVED, Boolean.TRUE);
        model.getProperties().putValue(PreviewProperty.EDGE_COLOR, new EdgeColor(Color.GRAY));
        model.getProperties().putValue(PreviewProperty.EDGE_THICKNESS, new Float(0.1f));
        model.getProperties().putValue(PreviewProperty.EDGE_LABEL_FONT, new Font("Arial", Font.PLAIN,32));
        model.getProperties().putValue(PreviewProperty.EDGE_LABEL_OUTLINE_SIZE,50);
        model.getProperties().putValue(PreviewProperty.DIRECTED,Boolean.TRUE);
        model.getProperties().putValue(PreviewProperty.CATEGORY_EDGE_ARROWS,Boolean.TRUE);
        model.getProperties().putValue(PreviewProperty.ARROW_SIZE, 10);

        //http://bits.netbeans.org/7.4/javadoc/org-openide-util-lookup/org/openide/util/lookup/doc-files/index.html
        ExportController ec = Lookup.getDefault().lookup(ExportController.class);
        try {
            ec.exportFile(new File(outputFilename));
            System.out.println("Write file: "+outputFilename);
        } catch (Exception e){
            System.out.println("yikes. Error writing image. "+e.getMessage());
        }
    }

    private static Workspace importGraphML(File graphmlFile, Workspace workspace) {
        // get import controller
        ImportController importController = Lookup.getDefault().lookup(ImportController.class);
        FileImporter fileImporter = importController.getFileImporter(".graphml");
        //Import file
        try {
            Container container = importController.importFile(graphmlFile,fileImporter);
            System.out.println("Read graphml file");
            container.getLoader().setEdgeDefault(EdgeDirectionDefault.DIRECTED);
            importController.process(container, new DefaultProcessor(), workspace);
        } catch (Exception e){
            System.out.println("yikes. Error Importing file. "+e.getMessage());
        }
        //Append imported data to GraphAPI
        return workspace;
    }
}
