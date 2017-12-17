
import org.gephi.graph.api.*;
import org.gephi.io.exporter.api.ExportController;
import org.gephi.io.importer.api.Container;
import org.gephi.io.importer.api.EdgeDirectionDefault;
import org.gephi.io.importer.api.ImportController;
import org.gephi.io.importer.spi.FileImporter;
import org.gephi.io.processor.plugin.DefaultProcessor;
import org.gephi.project.api.ProjectController;
import org.gephi.project.api.Workspace;
import org.openide.util.Lookup;

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
        listNodes(directedGraph);
        String outputFilename="graph.png";
        exportGraphMLToFile(outputFilename);

    }

    private static void processGraph(Workspace workspace){
        //Get a graph model - it exists because we have a workspace
        GraphModel graphModel = Lookup.getDefault().lookup(GraphController.class).getGraphModel(workspace);
        DirectedGraph directedGraph = graphModel.getDirectedGraph();
        setLabelToDescription(directedGraph);

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