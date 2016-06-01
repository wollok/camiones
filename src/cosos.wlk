/**
 * Un "coso", en forma abstracta, es algún tipo de contenedor (caja, bulto o bidón)
 * de un elemento.
 */
class Coso {
	var elemento
	
	constructor(unElemento){
		elemento = unElemento
	}
	
	method peso()
}

/** 
 * Una caja contiene una determinada cantidad, medida en kg., de un elemento. 
 */
class Caja inherits Coso {
	var peso
	
	constructor(unElemento, unPeso) = super(unElemento){
		peso = unPeso
	}
	override method peso() = peso
}

class Bulto inherits Coso {
	var cantidad
	var caja
	
	constructor(unElemento, unPeso, unaCantidad) = super(unElemento){ 
		caja = new Caja(unElemento, unPeso)
		cantidad = unaCantidad
	}	
	override method peso() = caja.peso() * cantidad
}

class Bidon inherits Coso {
	var densidad
	var capacidad
	
	constructor(unElemento, unaCapacidad, unaDensidad) = super(unElemento){
		densidad = unaDensidad
		capacidad = unaCapacidad
	}
	override method peso() = densidad * capacidad
}
