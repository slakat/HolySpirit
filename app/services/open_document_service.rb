class OpenDocumentService

  def initialize
    @connection = Faraday.new(url: 'https://api.foursquare.com/v2/venues/')
      #https://api.foursquare.com/v2/venues/search?ll=40.7,-74&client_id=IWTATDDQVHJUEH3NAR2JDWKTEIYCWRLERL1NWQ3THRCJ2LCL&client_secret=H1SUMPWAHNRLOFE3DPWPMDNO3WIFJQPEFMQXZFVA4MFNHAJB&v=YYYYMMDD
      #
      #https://api.foursquare.com/v2/venues/search?venues/explore?near=Santiago&client_id=IWTATDDQVHJUEH3NAR2JDWKTEIYCWRLERL1NWQ3THRCJ2LCL&client_secret=H1SUMPWAHNRLOFE3DPWPMDNO3WIFJQPEFMQXZFVA4MFNHAJB&v=20151208
      #
      #client_id = IWTATDDQVHJUEH3NAR2JDWKTEIYCWRLERL1NWQ3THRCJ2LCL
      #client_secret=H1SUMPWAHNRLOFE3DPWPMDNO3WIFJQPEFMQXZFVA4MFNHAJB
      #&v=20130815
      #&ll=40.7,-74
      #&query=sushi
      #?near=Santiago'
  end
  @client_id = 'IWTATDDQVHJUEH3NAR2JDWKTEIYCWRLERL1NWQ3THRCJ2LCL'
 @client_secret= 'H1SUMPWAHNRLOFE3DPWPMDNO3WIFJQPEFMQXZFVA4MFNHAJB'

  def get_documents_for(x, y, max) #near x,y

#       no quiere trabajar ni tirar error

        #response = @connection.get('explore?near=Santiago&client_id=IWTATDDQVHJUEH3NAR2JDWKTEIYCWRLERL1NWQ3THRCJ2LCL&client_secret=H1SUMPWAHNRLOFE3DPWPMDNO3WIFJQPEFMQXZFVA4MFNHAJB&v=20151208')
          @response = @connection.get "explore?ll=#{x},#{y}", { :client_id => @client_id, :client_secret => @client_secret }
          
          if @response.success?
            json = JSON.parse(response.body)
            @resources = []
            (json['result'] || []).map { |item| item['resources'] }.flatten.each do |resource|
              break if max && @resources.size >= max
              @resources << @resource unless @resource['name'].blank?
            end
            @resources
          end
        rescue
          # respuesta nil para cualquier error
        end
end
