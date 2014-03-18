module MoviesHelper
 def format_total_gross(movie)
   if movie.flop?
    content_tag(:strong, 'Flop!')
   else
     number_to_currency(movie.total_gross)
   end
 end
 
 #def image_for(movie)
 #  if movie.image_file_name.blank?
 #    image_tag('placeholder.png')
 #  else
 #    image_tag(movie.image_file_name)
 #  end
 #end

 # Edited after the paper clip gem impl
 # image.url is used to get the image from public folder
 def image_for(movie)
   if movie.image.exists?
     image_tag(movie.image.url,size: "90x124")
   else
     image_tag('placeholder.png')
   end
 end
end
