require './lib/lopic'

RSpec.describe 'Lopic' do
  describe 'create_images_array' do
    describe 'we have images' do
      it 'must create array' do
        document = Nokogiri::HTML('
          <html>
            <body>
              <h1>Image Gallery</h1>
              <img src="http://www.msf-me.org/en/media/get/20100902_img-test.jpg", alt="test alt text">
              <img src="http://www.msf-me.org/en/media/get/20100902_img-test.jpg">
              <img src="http://www.msf-me.org/en/media/get/20100902_img-test.jpg", alt="">
              <img src="http://www.msf-me.org/en/media/get/20100902_img-test.jpg">
              <img src="http://www.msf-me.org/en/media/get/20100902_img-test.jpg", alt="second test alt text">
              <a href="#">
                <img src="http://www.msf-me.org/en/media/get/20100902_img-test.jpg">
                <div>
                  <img src="http://www.msf-me.org/en/media/get/20100902_img-test.jpg", alt="div test alt text">
                </div>
              </a>
            </body>
          </html>
        ')

        expect(Lopic.send(:create_images_array, document)).to eq([
                                                                   {
                                                                     src: 'http://www.msf-me.org/en/media/get/20100902_img-test.jpg', alt: 'test alt text'
                                                                   },
                                                                   { src: 'http://www.msf-me.org/en/media/get/20100902_img-test.jpg', alt: '' },
                                                                   {
                                                                     src: 'http://www.msf-me.org/en/media/get/20100902_img-test.jpg', alt: ''
                                                                   },
                                                                   { src: 'http://www.msf-me.org/en/media/get/20100902_img-test.jpg', alt: '' },
                                                                   {
                                                                     src: 'http://www.msf-me.org/en/media/get/20100902_img-test.jpg', alt: 'second test alt text'
                                                                   },
                                                                   { src: 'http://www.msf-me.org/en/media/get/20100902_img-test.jpg', alt: '' },
                                                                   {
                                                                     src: 'http://www.msf-me.org/en/media/get/20100902_img-test.jpg', alt: 'div test alt text'
                                                                   }
                                                                 ])
      end
    end

    describe 'without images' do
      it 'has empty array' do
        first_document = Nokogiri::HTML('
          <html>
            <body>
              <h1>Image Gallery</h1>
            </body>
          </html>
        ')
        second_document = Nokogiri::HTML('')
        expect(Lopic.send(:create_images_array, first_document)).to eq([])
        expect(Lopic.send(:create_images_array, second_document)).to eq([])
      end
    end
  end

  describe 'valid_url?' do
    it 'must be valid' do
      expect(Lopic.send(:valid_url?, 'http://www.somesite.com')).to be_truthy
      expect(Lopic.send(:valid_url?, 'https://www.somesite.com')).to be_truthy
      expect(Lopic.send(:valid_url?, 'https://somesite.com')).to be_truthy
      expect(Lopic.send(:valid_url?, 'wwwsome_site.ru')).to be_truthy
      expect(Lopic.send(:valid_url?, 'https://somesite.com/some_page')).to be_truthy
      expect(Lopic.send(:valid_url?, 'https://somesite.com/some_page/page')).to be_truthy
      expect(Lopic.send(:valid_url?, 'https://somesite.com.uk/some_page')).to be_truthy
    end

    it 'does not valid' do
      expect(Lopic.send(:valid_url?, 'some_site')).to be_falsey
      expect(Lopic.send(:valid_url?, 'http\\:wwwsome_site.ru')).to be_falsey
      expect(Lopic.send(:valid_url?, 'com.some_site')).to be_falsey
    end
  end

  describe 'private hash equal' do
    it 'not_valid_url_error hash' do
      expect(Lopic.send(:not_valid_url_error)).to eq({
                                                       success: false,
                                                       error: 'url is not valid'
                                                     })
    end

    it 'nokogiri_error hash' do
      expect(Lopic.send(:nokogiri_error)).to eq({
                                                  success: false,
                                                  error: 'error with parsing a document'
                                                })
    end

    it 'success_hash hash' do
      expect(Lopic.send(:success_hash)).to eq({
                                                success: 'true',
                                                error: ''
                                              })
    end
  end
end

