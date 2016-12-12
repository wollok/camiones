class NoPuedeRealizarAccion inherits wollok.lang.Exception{
	var camion
	constructor(unCamion, unTexto) = super(unTexto){
		camion = unCamion
	}
}

/**
 * Estado genérico. Sólo se incluye el comportamiento por defecto para los estados concretos.
 */
class Estado{
	/* En algunos puntos se necesita consultar el estado. 
	 * Tratar de evitar cuando sea posible.
	 */
	method disponible() = false
	method enReparacion() = false
	method enViaje() = false
	
	/*
	 * Muchas acciones pueden hacerse o no dependiendo del estado.
	 */
	method salirDeReparacion(unCamion){
		throw new NoPuedeRealizarAccion(unCamion, "No está en reparación")
	}
	method salirDeViaje(unCamion){
		throw new NoPuedeRealizarAccion(unCamion, "No está disponible")
	}
	method volverDeViaje(unCamion){
		throw new NoPuedeRealizarAccion(unCamion, "No está viajando")
	}
	method pasarAReparacion(unCamion){
		throw new NoPuedeRealizarAccion(unCamion, "No está disponible")
	}
	method puedeCargar(unCamion, unCoso) = false
	method listoParaPartir(unCamion) = false
}

object disponible inherits Estado {
	override method disponible() = true
	override method puedeCargar(unCamion, unCoso) = unCamion.tieneCapacidadPara(unCoso)
	override method salirDeViaje(unCamion){	
		unCamion.estado(enViaje)
	}
	override method pasarAReparacion(unCamion){
		unCamion.estado(enReparacion)
	}
	override method listoParaPartir(unCamion) = unCamion.bienCargado()
}

object enReparacion inherits Estado {
	override method enReparacion() = true 
	override method salirDeReparacion(unCamion){
		unCamion.estado(disponible)
	}
}

object enViaje inherits Estado {
	override method enViaje() = true
	override method volverDeViaje(unCamion){
		unCamion.estado(disponible)
	}
}