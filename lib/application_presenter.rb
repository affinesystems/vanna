class ApplicationPresenter < ActionController::Metal
  abstract!
  include ActionController::MimeResponds
  include AbstractController::Rendering
  append_view_path "views"
  
  #These are just here to stop errors, they do nothing
  respond_to :html, :json
  def freeze_formats(f); end
  def formats; [:html, :json]; end
  
  def controller
    self
  end


end
module ActionController
  class Responder
    protected
    def default_render
      controller.response_body = request.format.symbol == :json ?
        options.to_json : controller.render
    end
  end
end
=begin
class ApplicationPresenter < ActionController::Metal


  include ActionView::Context
  def _render_template_from_controller(template, layout = DEFAULT_LAYOUT, options = {}, partial = false)
    template.template = template_string
    ret = template.render(self, options)
    layout.render(self, options) { ret }
  end
 
  DEFAULT_LAYOUT = Object.new.tap {|l| def l.render(*) JsonTemplateRenderer.tag + 
    "<body><div id=main></div></body>"+ yield end }

  
end
=end