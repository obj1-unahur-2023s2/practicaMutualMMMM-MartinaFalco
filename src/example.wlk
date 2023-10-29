//Actividades que ofrece la mutual
class Actividad{
	const actividades =#{}
	method aniadirActividad(actividad) = actividades.add(actividad)
}

class Viaje{
	const idiomas =#{}
	method aniadirIdioma(idioma) = idiomas.add(idioma) 
	method sirveParaBroncearse()
	method implicaEsfuerzo()
	method dias()
	method esInteresante() = idiomas.size() > 1
	method esRecomendadaPara(socio) = self.esInteresante() and socio.leAtraeLaActividad(self) and not self.realizoEstaActividad(socio)
	method realizoEstaActividad(socio) = socio.actividadesRealizadas().contains(self)
}

class ViajeDePlaya inherits Viaje{
	var property playa
	override method dias() = playa.largo() / 500
	override method implicaEsfuerzo() = playa.largo() > 1200
	override method sirveParaBroncearse() = true
}

class Playa{
	var property largo = 0
}

class ExcursionCiudad inherits Viaje{
	var property atracciones = 0
	override method dias() = atracciones/2
	override method implicaEsfuerzo() = atracciones.between(5,8)
	override method sirveParaBroncearse() = false
	override method esInteresante() = super() or atracciones == 5
}

class ExcursionCiudadTropical inherits ExcursionCiudad{
	override method sirveParaBroncearse() = true
	override method dias() = super() +1
}

class SalidaTrekking inherits Viaje{
	var property kilometros = 0
	var property diasDeSol = 0
	override method dias() = kilometros/50
	override method implicaEsfuerzo() = kilometros > 80
	override method sirveParaBroncearse() = ((diasDeSol > 200) or (diasDeSol.between(100,200)) and kilometros > 120) 
	override method esInteresante() = super() and diasDeSol > 140
}

class ClaseGimnasia{
	const idiomas = "Español"
	method sirveParaBroncearse() = false
	method implicaEsfuerzo() = true
	method dias() = 1
	method esRecomendadaPara(socio) = socio.edad().between(20,30
		
	)
}

//Socios de la mutual

class Socio{
	const actividadesRealizadas =#{}
	const idiomasQueHabla =#{}
	var property edad = 0
	var property maximoDeActividades = 0
	method aniadirActividad(actividad) = 
	if (actividadesRealizadas.size() < maximoDeActividades){
		actividadesRealizadas.add(actividad)
	} 
	else{
		throw new LlegoAlMaximo(message="Máximo alcanzado, no se puede realizar otra actividad")
	}
	method esAdoradorDelSol() = actividadesRealizadas.all{a =>a.sirveParaBroncearse()}
	method actividadesEsforzadas() = actividadesRealizadas.filter{a=>a.implicaEsfuerzo()}
	method leAtraeLaActividad(actividad)
}


class SocioTranquilo inherits Socio{
	override method leAtraeLaActividad(actividad) = actividad.dias() >= 4
}

class SocioCoherente inherits Socio{
	override method leAtraeLaActividad(actividad) = 
	if(self.esAdoradorDelSol()){actividad.sirveParaBroncearse()}
	else{actividad.implicaEsfuerzo()}
}

class SocioRelajado inherits Socio{
	override method leAtraeLaActividad(actividad) = (idiomasQueHabla.intersection(actividad.idiomas())).size() >=1
}

class LlegoAlMaximo inherits Exception{
	
}