
BasicConfigurator.configure()
/**
 * 
 */

import org.apache.log4j.BasicConfigurator
import org.elasticsearch.groovy.node.GNode
import org.elasticsearch.groovy.node.GNodeBuilder
import static org.elasticsearch.groovy.node.GNodeBuilder.*

// on startup

GNodeBuilder nodeBuilder = nodeBuilder();
nodeBuilder.settings {
    node {
        client = true
    }
    cluster {
        name = "test"
    }
}

GNode node = nodeBuilder.node()

// on shutdown

node.stop().close()
