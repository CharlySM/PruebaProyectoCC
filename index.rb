require 'sinatra'
require 'io/console'
require 'json'
require './src/Utils'
require 'mongo'

set :bind, "0.0.0.0"



##database = client.database

#class Aplicacion < Sinatra::Base

#set :port, 80
num=0
num2=0
asig=""
apunte=""
asigInsert=""
apunteInsert=""
year=""
mes=""
dia=""
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
@insertarAgenda2=0
numInsertarAgenda2=0
@buscaAgenda=0
numBuscaAgenda=0
@botonBuscaAgenda=1
numBotonBuscaAgenda=1

Utils=Utils.instance

# Index web page. Its the main page to applicaction
get '/' do
  ##print collection.find.first
  #print database.collection_names
  @links=Utils.returnJson(asig, apunte, num, collection)
  #print @links.to_json
  @busca=numBusca
  @botonBusca=numBotonBusca
  @inserta=numInserta
  @botonInserta=numBotonInserta
  @all=numAll
  @botonAll=numBotonAll
  @agenda=numAgenda
  @botonAgenda=numBotonAgenda
  @listaAgenda=Utils.returnJsonAgenda(dia, mes, year, num2)
##  print @listaAgenda
  num2=0
  @insertAgenda=numInsertarAgenda
  @insertAgenda2=numInsertarAgenda2
  @buscaAgenda=numBuscaAgenda
  @botonBuscaAgenda=numBotonBuscaAgenda
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

post '/activaInsertarAgenda2' do
  numInsertarAgenda2=1
  redirect '/'
end

post '/insertarAgenda' do
  nota=params[:nota]
  fecha=""
  if params[:fecha]!=nil
    fecha=params[:fecha]
  else
    fecha=Utils.getCurrentDate()
  end
  agendaInsert = Utils.getJson("./agenda/agenda.json")
  #split=Utils.getCurrentDate()
  numInsertarAgenda=0
  numInsertarAgenda2=0
  agendaInsert=Utils.insertEntradaAgenda(agendaInsert, nota, fecha)
  Utils.insertJsonIntoFile("./agenda/agenda.json", agendaInsert)

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

post '/hideInsertAgenda2' do
  #numAgenda=0
  #numBotonAgenda=1
  numInsertarAgenda2=0
  redirect '/'
end

post '/activaBuscaAgenda' do
  numBuscaAgenda=1
  numBotonBuscaAgenda=0
  redirect '/'
end

post '/buscaAgenda' do
  year = params[:year]
  mes = params[:mes]
  dia = params[:dia]
  numBuscaAgenda=0
  numBotonBuscaAgenda=1
  num2=1
  redirect '/'
end

post '/hideBuscaAgenda' do
  numBuscaAgenda=0
  numBotonBuscaAgenda=1
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
  linksInsert = Utils.getJson("./links/links.json")
  n=collection.count
  doc={_id:"#{n+1}","#{params[:asig]}-#{params[:apunte]}":"#{params[:enlace]}"}
  collection.insert_one(doc)
  linksInsert["#{asigInsert}-#{apunteInsert}"] = enlaceInsert

  Utils.insertJsonIntoFile("./links/links.json", linksInsert)
  redirect '/'
end
