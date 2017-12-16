
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
        System.out.println("Base Directory:"+System.getProperty("user.dir"));
        File graphmlFile = new File("src/main/resources/Sample.graphml");
        System.out.println("File size (if 0, then something isn't right):"+graphmlFile.length());
        //Init a project - and therefore a workspace
        ProjectController pc = Lookup.getDefault().lookup(ProjectController.class);
        pc.newProject();
        pc.newWorkspace(pc.getCurrentProject());
        Workspace workspace = pc.getCurrentWorkspace();

        // get import controller
        ImportController importController = Lookup.getDefault().lookup(ImportController.class);
        FileImporter fileImporter = importController.getFileImporter(".graphml");
        //Import file
        try {
            Container container = importController.importFile(graphmlFile,fileImporter);

            System.out.println("Container is null? "+(null==container)+ " : " );
            System.out.println("source="+container.getSource());
            System.out.println("verify()="+container.verify() );
            System.out.println("Read graphml file");
            container.getLoader().setEdgeDefault(EdgeDirectionDefault.UNDIRECTED);
            System.out.println("Container is null?"+(null==container));
            importController.process(container, new DefaultProcessor(), workspace);
        } catch (Exception e){
            System.out.println("yikes. "+e.getMessage());
        }
        //Append imported data to GraphAPI


        //Export graph to PDF
        ExportController ec = Lookup.getDefault().lookup(ExportController.class);
        try {
            ec.exportFile(new File("graph.pdf"));
        } catch (Exception e){
            System.out.println("yikes. "+e.getMessage());
        }
    }
}
