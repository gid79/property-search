import com.logicalpractice.property.Bootstrap
import org.elasticsearch.ElasticSearchException
import org.elasticsearch.action.ActionFuture
import org.elasticsearch.action.ActionListener
import org.elasticsearch.action.bulk.BulkResponse
import org.elasticsearch.action.index.IndexRequest
import org.elasticsearch.client.transport.TransportClient
import org.elasticsearch.common.transport.InetSocketTransportAddress
import org.elasticsearch.groovy.client.GClient
import org.slf4j.Logger
import org.slf4j.LoggerFactory

import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit

/**
 * 
 */

Bootstrap.boot()
GClient client = new GClient(new TransportClient()
    .addTransportAddress(new InetSocketTransportAddress("localhost",9300)))

def columns = []
Logger logger = LoggerFactory.getLogger("load")

def threadPool = Executors.newFixedThreadPool(2)

def currentBulk = client.client.prepareBulk()

def futures = []
new File("ActivePropertyList.txt").eachLine() { line, i ->

    switch(i) {
        case 1:
            columns = line.split(/\|/) collect { it[0].toLowerCase() + it[1..-1] }
            columns[0] = "id"
            break;
        default:
            values = line.split(/\|/)
            def map = [:]
            values.eachWithIndex{ String value, int index ->
                map.put columns[index], value
            }

            currentBulk.add(client.prepareIndex("hotel", "hotel", values.first() as String).setSource(map))
            break
    }

    if( currentBulk.numberOfActions() == 200 ) {
        futures << currentBulk.execute()
        currentBulk = client.client.prepareBulk()
    }
}

if( currentBulk.numberOfActions() > 0 ){
    futures << currentBulk.execute()
}

futures.each { ActionFuture f ->
    try {
        f.actionGet()
    } catch (ElasticSearchException e) {
        logger.warn("Failure", e)
    }
}

client.client.close()