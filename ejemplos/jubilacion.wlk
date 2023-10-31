object empresa{
	const empleados = []
	method listaDeInvitados() = empleados.filter{empleado => empleado.esInvitado()}
	method cantidadDeInvitados() = self.listaDeInvitados().size()
	
}

class Personal{
	const lenguajes =#{}
	method sabeLenguajeAntiguo() = lenguajes.any{l=> l.esAntiguo()}
	method aprenderLenguaje(lenguaje){lenguajes.add(lenguaje)} 
	method cantidadDeLenguajes() = lenguajes.size()
	method cantidadDeLenguajesModernos() = lenguajes.count{l=> not l.esAntiguo()}
	method nroMesa() = self.cantidadDeLenguajesModernos()
	method regalo() = self.cantidadDeLenguajesModernos() * 1000
}

class Lenguaje{
	var property nombre = ""
	var property esAntiguo = true
	method esWollok() = nombre == "Wollok"
	method dejarDeSerAntiguo() = not esAntiguo
}

class Desarrollador inherits Personal{
	method sabeWollok() = lenguajes.any{l=>l.esWollok()}
	method esInvitado() = self.sabeWollok() or self.sabeLenguajeAntiguo()
	method esCapaz() = self.sabeLenguajeAntiguo()
}

class Infra inherits Personal{
	var property aniosDeExperiencia = 0
	method esInvitado() = self.cantidadDeLenguajes() >= 5
	method esCapaz() = aniosDeExperiencia>10
}

class Jefe inherits Personal{
	const personasACargo =#{}
	method tomarACargo(persona){personasACargo.add(persona)}
	method esJefeDe(persona) = personasACargo.contains(persona)
	method tieneACargoAlguienCapaz()= personasACargo.any{p=>p.esCapaz()}
	method esInvitado() = self.sabeLenguajeAntiguo() and self.tieneACargoAlguienCapaz() and not self.esJefeDe(juanPerez)
	method cantidadDePersonasACargo() = personasACargo.size()
	override method nroMesa() = 99
	override method regalo() = super() + self.cantidadDePersonasACargo() * 1000
}

object juanPerez{
	
}

class NoInvitado inherits Exception{
	
}

object fiesta{
	const asistencia =#{}
	const n = 1
	method registrarAsistencia(persona){
		if (persona.esInvitado()){
			asistencia.add(
			new Registro(invitado = persona, nroOrden = self.nroOrden(), nroMesa = persona.nroMesa())
			)}
		else{
		throw new NoInvitado(message = "No está en la lista de invitados")
		}
	}
	method nroOrden() = asistencia.size() + 1
	method importeRegalos() = asistencia.count{a=>a.regalo()} 
	method balance() = self.importeRegalos() - 200000
	method fueExcelente() = asistencia.size() ==  empresa.cantidadDeInvitados()
	method nroRandom() = n.randomUpTo(100).truncate(0)  
	method sorteo() =  asistencia.find{a=>a.nroOrden() == self.nroRandom()}
}

class Registro{
	var property invitado
	var property nroOrden
	var property nroMesa
	
}
