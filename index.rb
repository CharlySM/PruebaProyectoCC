require 'sinatra'
require 'io/console'
require 'json'
require './src/Utils'

set :bind, "0.0.0.0"

#class Aplicacion < Sinatra::Base

#set :port, 80
num=0
asig=""
apunte=""
asigInsert=""
apunteInsert=""
@busca=0
numBusca=0
@botonBusca=1
numBotonBusca=1
@botonInserta=1
numBotonInserta=1
@inserta=0
numInserta=0
@links
@all=0
numAll=0
@botonAll=1
numBotonAll=1
@botonAgenda=1
numBotonAgenda=1
@agenda=0
numAgenda=0
@fecha=""
@nota=""
@insertarAgenda=0
numInsertarAgenda=0

Utils=Utils.instance

# Index web page. Its the main page to applicaction
get '/' do
  @links=Utils.returnJson(asig, apunte, num)
  @busca=numBusca
  @botonBusca=numBotonBusca
  @inserta=numInserta
  @botonInserta=numBotonInserta
  @all=numAll
  @botonAll=numBotonAll
  @agenda=numAgenda
  @botonAgenda=numBotonAgenda
  @listaAgenda=Utils.getJson("agenda.json")
  @insertAgenda=numInsertarAgenda

  erb :index
end

post '/search' do
  asig = params[:asig]
  apunte = params[:apunte]
  num=1
  numBusca=0
  numBotonBusca=1
  redirect '/'
end

post '/activaBusca' do
  numBusca=1
  numBotonBusca=0
  redirect '/'
end

post '/hideBusca' do
  numBusca=0
  numBotonBusca=1
  redirect '/'
end

post '/activaInserta' do
  numInserta=1
  numBotonInserta=0
  redirect '/'
end

post '/hideInserta' do
  numInserta=0
  numBotonInserta=1
  redirect '/'
end

post '/activaAll' do
  numAll=1
  numBotonAll=0
  redirect '/'
end

post '/hidelinks' do
  numAll=0
  numBotonAll=1
  numInserta=0
  numBotonInserta=1
  numBusca=0
  numBotonBusca=1
  redirect '/'
end

post '/activaInsertarAgenda' do
  numInsertarAgenda=1
  redirect '/'
end

post '/insertarAgenda' do
  nota=params[:nota]
  agendaInsert = Utils.getJson("agenda.json")
  split=Utils.getCurrentDate()
  numInsertarAgenda=0
  agendaInsert=Utils.insertEntradaAgenda(agendaInsert, nota, split)
  Utils.insertJsonIntoFile("agenda.json", agendaInsert)

  redirect '/'
end

post '/activaAgenda' do
  numAgenda=1
  numBotonAgenda=0
  redirect '/'
end

post '/hidelinks' do
  numAll=0
  numBotonAll=1
  numInserta=0
  numBotonInserta=1
  numBusca=0
  numBotonBusca=1
  redirect '/'
end

post '/hideInsertAgenda' do
  #numAgenda=0
  #numBotonAgenda=1
  numInsertarAgenda=0
  redirect '/'
end

post '/hideAgenda' do
  numAgenda=0
  numBotonAgenda=1
  numInsertarAgenda=0
  redirect '/'
end

post '/inserta' do
  asigInsert = params[:asig]
  apunteInsert = params[:apunte]
  enlaceInsert = params[:enlace]
  numInserta=0
  numBotonInserta=1
  linksInsert = Utils.getJson("links.json")
  linksInsert["#{asigInsert}-#{apunteInsert}"] = enlaceInsert
  Utils.insertJsonIntoFile("links.json", linksInsert)
  redirect '/'
end
