import estados.*
import cosos.* 

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
	
	/** <b>Ejercicios A + C</b><br>
	 * Cargar el camión con un “coso”, donde el coso puede ser un bulto, una caja suelta, 
	 * o un bidón. Sólo se carga si puede hacerse. <br>
	 * Por ejemplo, si a un camión con capacidad para 150 Kg. que ya tenia 140 Kg. se le pide 
	 * que cargue un bulto de 10 Kg. lo haga, pero si se pide que cargue un bidón de 25 Kg.
	 * no lo haga, porque con este superaría su capacidad máxima. 
	 * */
	method cargar(unCoso){
		if(estado.puedeCargar(self, unCoso))
			cosos.add(unCoso)
		else
			throw new NoPuedeRealizarAccion(self, "No puede cargarse")
	}
	
	/**<b>Ejercicio B</b><br> 
	 * Saber si un camión puede cargar un coso. Un camión puede aceptarlo si con lo que 
	 * le preguntan si puede cargar más lo que ya tiene cargado no supera su carga máxima, 
	 * y además está disponible para la carga.
	 * */
	method puedeCargar(unCoso) = estado.puedeCargar(self, unCoso)
	
	method tieneCapacidadPara(unCoso) = 
		self.pesoCargado() + unCoso.peso() <= capacidadMaxima
	
	method pesoCargado() = cosos.sum({unCoso => unCoso.peso()})
	
	/**<b>Ejercicio D.i</b><br> 
	 * Un camión sale de reparación y queda disponible para la carga.
	 */
	method salirDeReparacion(){
		estado.salirDeReparacion(self)
	}
	
	/** <b>Ejercicio D.ii</b><br> 
	 * Un camión pasa a reparación.
	 */
	method pasarAReparacion(){
		estado.pasarAReparacion(self)
	}
	
	/** <b>Ejercicio D.iii</b><br> 
	 * Un camión pasa a reparación.
	 */
	method salirDeViaje(){
		estado.salirDeViaje(self)
	}
	
	/** <b>Ejercicio D.iv</b><br> 
	 * Un camión vuelve de viaje y queda disponible para la carga.
	 */
	method volverDeViaje(){
		estado.volverDeViaje(self)
	}
	
	/** <b>Ejercicio E</b><br> 
	 * Saber si un camión está listo para partir, que es cuando está disponible para la 
	 * carga y el peso total de lo que tiene cargado es de al menos 75% de su carga máxima. 
	 */
	method listoParaPartir() = estado.listoParaPartir(self)
	
	method bienCargado() = 
		self.pesoCargado() >= self.capacidadMaxima() * minimoBienCargado

	method estaViajando() = estado == enViaje
	
	method totalCarga() = cosos.sum({unCoso => unCoso.peso()})
	
	method pesoTotalDe(unElemento) = 
		cosos
			.filter({unCoso => unCoso.elemento() == unElemento})
			.sum({unCoso => unCoso.peso()})			 
	
	/** <b>Ejercicio G</b><br> 
	 * Saber los elementos que están cargados en un determinado camión 
	 * */
	method elementos() = cosos.map({unCoso => unCoso.elemento()}).asSet() 
	
	/** <b>Ejercicio I</b><br>  
	 * Dados dos camiones obtener los elementos que se transportan en los dos. 
	 * Por ejemplo, si se tiene un camión que transporta galletitas, raids, alfajores y 
	 * aceite y tengo otro que transporta agua, galletitas, dentífrico y aceite, lo que 
	 * debería obtener es un conjunto con aceite y galletitas. 
	 */
	method contienenAmbos(otroCamion) = 
		self.elementos().intersection(otroCamion.elementos())
	
	/** <b>Ejercicio J</b><br>
	 * Para un camión, saber el coso (bulto, caja o bidón) más liviano que está 
	 * siendo transportado.
	 */
	method elementoMasLivianoTransportado() = cosos.min({unCoso => unCoso.peso()})
}