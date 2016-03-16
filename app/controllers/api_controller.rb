require 'digest'
require 'open-uri'
class ApiController < ApplicationController
  def validarFirma
  	if !params.key?('hash') || !params.key?('mensaje') 
  		render :nothing => true, :status => 400
  	else
  	@valid=false
  	@codificado=Digest::SHA256.hexdigest params['mensaje']

  	if (params['hash'].downcase==@codificado)
  		@valid=true
  	end	
  	render :status => 200, json: {valido:@valid , mensaje:params['mensaje']}
  	end
  end

  def status
  	render :nothing => true, :status => 201
  end
  def texto
    @text =open('http://s3.amazonaws.com/files.principal/texto.txt') { |f| f.read }
    @codificado=Digest::SHA256.hexdigest @text
    @text=@text.force_encoding(Encoding::UTF_8)
    render :status => 200, json: {text:@text , hash:@codificado}
  end
end
