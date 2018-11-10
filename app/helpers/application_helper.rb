module ApplicationHelper
  #image1,2,3の写真がなくても登録できるようにする。写真があれば表示し、なければダミーを表示する。
  def image1_url(product)
    if product.image1_url.present?
      image_tag product.image1_url
    else
      image_tag "https://placehold.it/180x180/?text=NoPicture"
    end
  end

  def image2_url(product)
    if product.image2_url.present?
      image_tag product.image2_url
    #else
    #  image_tag "https://placehold.it/180x180/?text=NoPicture"
    end
  end

  def image3_url(product)
    if product.image3_url.present?
      image_tag product.image3_url
    #else
    #  image_tag "https://placehold.it/180x180/?text=NoPicture"
    end
  end
end
