module ApplicationHelper
  def thumb_path(img)
    # Active storage gives
    # .service_url
    # IF you give params
    # it will add  &x-oss-process=style/thumb to end of url
    return img.service_url(params: {'x-oss-process'=> 'style/thumb'})
  end

end
