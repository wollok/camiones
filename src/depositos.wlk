import utils.*

class Deposito {
	const camiones = []
	
	/** Punto F */
	method totalCargaViajando() = 
		self.camionesViajando().sum({unCamion => unCamion.totalCarga()})
	method camionesViajando() = camiones.filter({unCamion => unCamion.estaViajando()})
	method agregarCamion(unCamion) {
		camiones.add(unCamion)
	}
	
	/** Punto H */
	method seEstaCargando(elemento) = self.camionesNoListosParaPartir().filter({unCamion => unCamion.elementosCargados().contains(elemento)})
	method camionesNoListosParaPartir() = camiones.filter({unCamion => !unCamion.listoParaPartir()})
	
	/** Punto K */
	method transportaMayorCantidadDeCosos() = camiones.max({unCamion => unCamion.cosos().size()})
	
	/** Punto L */
	method conjuntoDeCososCon(otroDeposito)  {
		var elementosEnComun = self.obtenerElementosEnComunCon(otroDeposito)
		var union = utils.union(self.obtenerCosasSegunElementosEnComun(elementosEnComun),otroDeposito.obtenerCosasSegunElementosEnComun(elementosEnComun))
		return union.sortedBy({unCoso, otroCoso => unCoso.peso() > otroCoso.peso()})
	}
	method obtenerCosasSegunElementosEnComun(elementosEnComun) = 
		self.obtenerCososDeposito().filter({unCoso => elementosEnComun.contains(unCoso.elemento())})
	method obtenerCososDeposito() = camiones.flatMap({unCamion => unCamion.cosos()})
	method obtenerElementosEnComunCon(otroDeposito) =
		 utils.intersection(self.obtenerElementosDeposito(), otroDeposito.obtenerElementosDeposito()).asSet()
	method obtenerElementosDeposito() = camiones.flatMap({unCamion => unCamion.elementosCargados()})
	
	
}