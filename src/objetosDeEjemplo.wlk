import camiones.*
import cosos.*
import depositos.*
 
object deposito inherits Deposito {}
object otroDeposito inherits Deposito {}
object camion inherits Camion(200) {}
object otroCamion inherits Camion(4000) {}
object caja inherits Caja("Ketchup", 50) {}
object bulto inherits Bulto("Ketchup", 40, 10) {}
object bidon inherits Bidon("Aceite", 10, 0.7) {}