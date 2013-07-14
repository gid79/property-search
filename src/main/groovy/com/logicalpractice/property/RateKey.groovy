package com.logicalpractice.property

import groovy.transform.CompileStatic
import groovy.transform.Immutable

/**
 *
 */
@Immutable
@CompileStatic
class RateKey {
    long hotel
    long room
}
