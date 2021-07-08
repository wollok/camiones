import estados.*
import cosos.* 

/**
 * Paradigmas de Programaci�n - UTN - FRBA
 *  
 * Implementaci�n del ejercicio 3 de la gu�a 3 "de papel" de 
 * objetos (colecciones) en versi�n Wollok. La misma se encuentra en:
 * http://pdep.com.ar/material/guas-de-ejercicios
 *  
 * WORK IN PROGRESS!!!
 */

/**
 * Un cami�n b�sico.
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
	 * Cargar el cami�n con un �coso�, donde el coso puede ser un bulto, una caja suelta, 
	 * o un bid�n. S�lo se carga si puede hacerse. <br>
	 * Por ejemplo, si a un cami�n con capacidad para 150 Kg. que ya tenia 140 Kg. se le pide 
	 * que cargue un bulto de 10 Kg. lo haga, pero si se pide que cargue un bid�n de 25 Kg.
	 * no lo haga, porque con este superar�a su capacidad m�xima. 
	 */
	method cargar(unCoso){
		if(estado.puedeCargar(self, unCoso))
			cosos.add(unCoso)
		else
			throw new NoPuedeRealizarAccion(self, "No puede cargarse")
	}
	
	/**<b>Ejercicio B</b><br> 
	 * Saber si un cami�n puede cargar un coso. Un cami�n puede aceptarlo si con lo que 
	 * le preguntan si puede cargar m�s lo que ya tiene cargado no supera su carga m�xima, 
	 * y adem�s est� disponible para la carga.
	 * */
	method puedeCargar(unCoso) = estado.puedeCargar(self, unCoso)
	
	method tieneCapacidadPara(unCoso) = 
		self.pesoCargado() + unCoso.peso() <= capacidadMaxima
	
	method pesoCargado() = cosos.sum({unCoso => unCoso.peso()})
	
	/**<b>Ejercicio D.i</b><br> 
	 * Un cami�n sale de reparaci�n y queda disponible para la carga.
	 */
	method salirDeReparacion(){
		estado.salirDeReparacion(self)
	}
	
	/** <b>Ejercicio D.ii</b><br> 
	 * Un cami�n pasa a reparaci�n.
	 */
	method pasarAReparacion(){
		estado.pasarAReparacion(self)
	}
	
	/** <b>Ejercicio D.iii</b><br> 
	 * Un cami�n pasa a reparaci�n.
	 */
	method salirDeViaje(){
		estado.salirDeViaje(self)
	}
	
	/** <b>Ejercicio D.iv</b><br> 
	 * Un cami�n vuelve de viaje y queda disponible para la carga.
	 */
	method volverDeViaje(){
		estado.volverDeViaje(self)
	}
	
	/** <b>Ejercicio E</b><br> 
	 * Saber si un cami�n est� listo para partir, que es cuando est� disponible para la 
	 * carga y el peso total de lo que tiene cargado es de al menos 75% de su carga m�xima. 
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
	 * Saber los elementos que est�n cargados en un determinado cami�n 
	 */
	method elementos() = cosos.map({unCoso => unCoso.elemento()}).asSet() 
	
	/** <b>Ejercicio I</b><br>  
	 * Dados dos camiones obtener los elementos que se transportan en los dos. 
	 * Por ejemplo, si se tiene un cami�n que transporta galletitas, raids, alfajores y 
	 * aceite y tengo otro que transporta agua, galletitas, dent�frico y aceite, lo que 
	 * deber�a obtener es un conjunto con aceite y galletitas. 
	 */
	method contienenAmbos(otroCamion) = 
		self.elementos().intersection(otroCamion.elementos())
	
	/** <b>Ejercicio J</b><br>
	 * Para un cami�n, saber el coso (bulto, caja o bid�n) m�s liviano que est� 
	 * siendo transportado.
	 */
	method elementoMasLivianoTransportado() = cosos.min({unCoso => unCoso.peso()})
}