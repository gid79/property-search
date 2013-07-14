
/**
 * 
 */


import com.logicalpractice.property.AvailablityCache


new File("RoomTypeList.txt").withReader { AvailablityCache.load( it ) }