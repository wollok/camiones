class Deposito {
	const camiones = []
	
	/** Punto F 
	 * Saber para un depósito el total de carga que está viajando, o sea la suma de lo que 
	 * llevan todos los camiones de ese depósito que están de viaje
	 * */
	method totalCargaViajando() = 
		self.camionesViajando().sum({unCamion => unCamion.totalCarga()})
		
	method camionesViajando() = 
		camiones.filter({unCamion => unCamion.estaViajando()})
		
	method agregarCamion(unCamion) {
		camiones.add(unCamion)
	}
	
	/** <b>Punto H</b><br>
	 * Saber en qué camiones de un depósito se están cargando un determinado elemento,
	 * por ejemplo ketchup o aceite. Decimos que un camión se está cargando cuando no 
	 * está listo para partir
	 */
	method seEstaCargando(elemento) = 
		self.camionesNoListosParaPartir().filter({
			unCamion => unCamion.elementos().contains(elemento)
		})

	method camionesNoListosParaPartir() = 
		camiones.filter({unCamion => not unCamion.listoParaPartir()})

	/** <b>Punto K</b><br>
	 * Para un depósito, saber el camión que transporta mayor cantidad de cosos.
	 */
	method transportaMayorCantidadDeCosos() = 
		camiones.max({unCamion => unCamion.cosos().size()})

	/** <b>Punto L</b><br> 
	 * Para dos depósitos, el conjunto de productos que están almacenados en ambos,
	 * ordenado por el peso de cada producto en forma ascendente.
	 */ 
	method elementosEnComunCon(otroDeposito) =
		self.elementos()
			.intersection(otroDeposito.elementos())
			.sortedBy({ unElemento, otroElemento =>		/* Orden ascendente por peso */
				self.pesoTotalCon(otroDeposito, unElemento) <=
				self.pesoTotalCon(otroDeposito, otroElemento)
			})
	
	method pesoTotalCon(otroDeposito, elemento) = 
		self.pesoTotalDe(elemento) + otroDeposito.pesoTotalDe(elemento)
		
	method pesoTotalDe(unElemento) = 
		camiones.sum({unCamion => unCamion.pesoTotalDe(unElemento)})
		
	method elementos() = camiones.flatMap({unCamion => unCamion.elementos()}).asSet()	
}