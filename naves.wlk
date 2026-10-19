// <<<<<<<<<< NAVES >>>>>>>>>>>
class Nave {
	var property velocidad = 0

	method recibirAmenaza()

	method propulsar() {
		velocidad = (300000).min(velocidad+20000)
	}

	method prepararViaje() {
		velocidad = (300000).min(velocidad+15000)
	}

	method encontrarseConEnemigo() {
		self.recibirAmenaza()
		self.propulsar()
	}
}




class NaveDeCargaRadioactiva inherits NaveDeCarga {
	override method recibirAmenaza(){
		velocidad = 0
	}

	override method prepararViaje(){
		super()
		self.recibirAmenaza()
	}
}

class NaveDeCarga inherits Nave {
	//var property velocidad = 0
	var property carga = 0


	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
	
	method enFalta() = self.sobrecargada() and self.excedidaDeVelocidad()
	
	method acercamientoDeControl() {
		if (self.enFalta()) {
			self.recibirAmenaza()
		}
	}
}

class NaveDePasajeros inherits Nave {
	//var property velocidad = 0
	var property alarma = false
	const cantidadDePasajeros = 0


	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaPermitida() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaPermitida() or alarma

	override method recibirAmenaza() {
		alarma = true
	}
}

class NaveDeCombate inherits Nave {
	//var property velocidad = 0
	var property modo = reposo
	const property mensajesEmitidos = []


	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method prepararViaje() {
		super()
		modo.mandarSMS(self)
	}
}


class Modo{
	method invisible() = false

	method recibirAmenaza(nave) {
	  nave.emitirMensaje(self.mensajePorRecibirAmenaza())
	}

	method mandarSMS(nave) {		
		nave.emitirMensaje(self.mensajePorPrepararViaje())
	}

	method mensajePorRecibirAmenaza()

	method mensajePorPrepararViaje()
}






object reposo inherits Modo {
	//method recibirAmenaza(nave) {
	//	nave.emitirMensaje("¡RETIRADA!")
	//}

	override method mandarSMS(nave){
		super(nave)
		nave.modo(ataque)
	}

	override method mensajePorRecibirAmenaza() = "¡RETIRADA!" 

	override method mensajePorPrepararViaje() = "Saliendo en misión"
}

object ataque inherits Modo {
	override method invisible() = true

	//method recibirAmenaza(nave) {
	//	nave.emitirMensaje("Enemigo encontrado")
	//}

	//method mandarSMS(nave){
	//	nave.emitirMensaje("Volviendo a la base")
	//}

	override method mensajePorRecibirAmenaza() = "Enemigo encontrado" 

	override method mensajePorPrepararViaje() = "Volviendo a la base"
}

// <<<<<<<<<<<<<<<<  >>>>>>>>>>>>>>>>>>
