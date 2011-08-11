class MainPage

  def self.write(text)
    page = File.new("cache/main_page.html", "w")

    page.close
  end
end
