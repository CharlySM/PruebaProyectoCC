require 'singleton'

class Utils

  include Singleton

  # Insert map into json file in param
  #
  # @param path [String, #read] the path of json file
  # @param map [Hashmap, #read] the json to save in json file
  def insertJsonIntoFile(path, map)
    File.open(path,"w+") do |f|
      f.write(map.to_json)
    end
  end

  # Get the json file in Hashmap type
  #
  # @param file [String, #read] the path of json file
  # @return [Hashmap] the contents of json file in hasmap

  def getJson(file)
    map={}
    if File.file?(file)
      map=JSON.parse(IO.read(file))
    end
  #  map=collection.find.to_json
    return map
  end

  def getCollection(file,collection)
    map={}
    #if File.file?(file)
    #  map=JSON.parse(IO.read(file))
    #end
    map=collection.find.to_a
    map=JSON.pretty_generate(map).sub("\"_id\"\:\.\,", "")
    print "map123455 ",map
    map=JSON.parse(map)
    return map
  end

  # Get the current date in array of string
  #
  # @return [Array] the current date in Array of String first position=year, second position=month third position=day
  def getCurrentDate()
    return Time.now.strftime("%d/%m/%Y")
  end

  # Search the element of hashmap and return the finding elements in hashmap
  #
  # @param asig [String, #read] the asig of element
  # @param apunte [String, #read] the name of element
  # @param links [hashmap, #read] the hashmap of elements
  # @return [Hashmap] the hashmap of the finding elements
  def searchIntoJson(asig, apunte, links)
    key="#{asig}-#{apunte}"
    map={}
    links.map{|k, v|
      if(k.include? key)
        map[k] = v
      end
      }
    if !map.empty?
      return map
    else
      return links
    end
  end

  # Search the element of hashmap and return the finding elements in hashmap or return all links in links.json
  #
  # @param asig [String, #read] the asig of element
  # @param apunte [String, #read] the name of element
  # @param num [int, #read] That num is 1 when the request was sent from Search Form, the num is 0 when the request was sent from all Links form
  # @param jsonName [String, #read] the name of json file
  # @return [Hashmap] the hashmap of the finding elements or all elemnts
  def returnJson(asig, apunte, num, collection)
    map=getCollection("./links/links.json", collection)
    if num==1
      map=searchIntoJson(asig, apunte, map)
    end
    return map
  end

  # Insert new note in agenda
  #
  # @param agendaInsert [Hashmap, #read] The hashmap of agenda
  # @param nota [String, #read] The new note of agenda
  # @param split [Array, #read] The current date in Array of String first position=year, second position=month third position=day
  # @return [Hashmap] the hashmap of agenda
  def insertEntradaAgenda(agendaInsert, nota, fecha)
    if agendaInsert.empty?
      agendaInsert={ fecha => [nota]}
    elsif agendaInsert["#{fecha}"] ==nil
      agendaInsert["#{fecha}"]= [nota]
    else
      agendaInsert["#{fecha}"] << nota
    end
    return agendaInsert
  end

  def searchAgenda(agenda, dia, mes, year)
    map={}
    key="#{dia}/#{mes}/#{year}"
    puts key
    agenda.map{|k,v|
          if((k.include? dia) && (k.include? mes) && (k.include? year))
            map[k] = v
          end
    }

    return map
  end

  def returnJsonAgenda(dia, mes, year, num)
    agenda=getJson("./agenda/agenda.json")
    if num==1
      agenda=searchAgenda(agenda, dia, mes, year)
    end
    return agenda
  end

end
