object utils {
	method intersection(collection1, collection2) = collection1.filter({element => collection2.contains(element)})
	method union(collection1, collection2) { 
		collection2.forEach({element => collection1.add(element)})
		return collection1
	}
		
}