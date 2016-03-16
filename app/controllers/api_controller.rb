require 'digest'
class ApiController < ApplicationController
  def validarFirma
  	
  	@valid=false
  	@codificado=Digest::SHA256.hexdigest params['mensaje']

  	if (params['hash'].downcase==@codificado)
  		@valid=true
  	end	
  	render :status => 200, json: {valido:@valid , mensaje:params['mensaje']}
  	
  end

  def status
  	render :nothing => true, :status => 201
  end
end
