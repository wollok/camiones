class Deposito {
	const camiones = []
	
	/** Punto F */
	method totalCargaViajando() = 
		self.camionesViajando().sum({unCamion => unCamion.totalCarga()})
	method camionesViajando() = camiones.filter({unCamion => unCamion.estaViajando()})
	method agregarCamion(unCamion) {
		camiones.add(unCamion)
	}
}