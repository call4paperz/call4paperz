module JSONPResponder
  def to_jsonp
    render :json => "#{callback}(#{resource.to_json});"
  end

  private
  def callback
    controller.params[:callback]
  end
end
