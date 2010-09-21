class Vanna < ActionController::Metal
  abstract!
  include ActionController::MimeResponds
  include AbstractController::Rendering
  include AbstractController::Callbacks

  append_view_path "app/views"
  
  #These are just here to stop errors, they do nothing
  respond_to :html, :json
  def freeze_formats(f); end
  def formats; [:html, :json]; end
 
  def logger
    ActionController::Base.logger
  end

  def process_action(method_name, *args)
    run_callbacks(:process_action, method_name) do
      dictionary = send_action(method_name, *args)
	  dictionary = @layout_pieces.merge(dictionary) if @layout_pieces
      self.response_body = request.format.symbol == :json ?
        dictionary.to_json : html_render(dictionary)
    end
  end
  def html_render(dictionary)
    render(nil, :locals => dictionary)
  end
end
