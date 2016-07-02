import estados.*
import cosos.*
import utils.* 

/**
 * Paradigmas de Programación - UTN - FRBA
 *  
 * Implementación del ejercicio 3 de la guía 3 "de papel" de 
 * objetos (colecciones) en versión Wollok. La misma se encuentra en:
 * http://pdep.com.ar/material/guas-de-ejercicios
 *  
 * WORK IN PROGRESS!!!
 */

/**
 * Un camión básico.
 */
class Camion {
	const minimoBienCargado = 0.75
	const cosos = []
	var capacidadMaxima
	var estado = disponible
	
	constructor(unaCapacidad) {
		capacidadMaxima = unaCapacidad
	}
	
	/* Getters */
	method cosos() = cosos
	method capacidadMaxima() = capacidadMaxima
	
	/* Setters */
	method estado(unEstado){
		estado = unEstado
	}
	
	/** Ejercicios A + C */
	method cargar(unCoso){
		if(estado.puedeCargar(self, unCoso))
			cosos.add(unCoso)
		else
			throw new NoPuedeRealizarAccion(self, "No puede cargarse")
	}
	
	/** Ejercicio B */
	method puedeCargar(unCoso) = estado.puedeCargar(self, unCoso)
	method tieneCapacidadPara(unCoso) = 
		self.pesoCargado() + unCoso.peso() <= capacidadMaxima
	method pesoCargado() = cosos.sum({unCoso => unCoso.peso()})
	
	/** Ejercicio D.i */
	method salirDeReparacion(){
		estado.salirDeReparacion(self)
	}
	/** Ejercicio D.ii */
	method pasarAReparacion(){
		estado.pasarAReparacion(self)
	}
	/** Ejercicio D.iii */
	method salirDeViaje(){
		estado.salirDeViaje(self)
	}
	/** Ejercicio D.iv */
	method volverDeViaje(){
		estado.volverDeViaje(self)
	}
	
	/** Ejercicio E */
	method listoParaPartir() = estado.listoParaPartir(self)
	method bienCargado() = 
		self.pesoCargado() >= self.capacidadMaxima() * minimoBienCargado

	method estaViajando() = estado == enViaje
	method totalCarga() = cosos.sum({unCoso => unCoso.peso()})
	
	/** Ejercicio G */
	method elementosCargados() = cosos.map({unCoso => unCoso.elemento()})
	
	/** Ejercicio I */
	method contienenAmbos(otroCamion) = utils.intersection(self.elementosCargados(), otroCamion.elementosCargados())
	
	/** Ejercicio J */
	method elementoMasLivianoTransportado() = cosos.min({unCoso => unCoso.peso()})	
	
	
}