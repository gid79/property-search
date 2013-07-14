package com.logicalpractice.property

import org.apache.log4j.BasicConfigurator
import org.elasticsearch.groovy.node.GNode
import org.elasticsearch.groovy.node.GNodeBuilder

import static org.elasticsearch.groovy.node.GNodeBuilder.nodeBuilder

/**
 *
 */
class Bootstrap {


    static boot() {
        BasicConfigurator.configure()
    }


}
