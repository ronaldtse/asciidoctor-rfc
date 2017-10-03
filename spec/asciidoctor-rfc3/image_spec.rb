require 'spec_helper'

xdescribe Asciidoctor::Rfc3::Converter do
  it 'renders an image' do
    expect(Asciidoctor.convert <<~'INPUT', backend: :rfc3).to match <<~'OUTPUT'.chomp
      [[id]]
      .Title
      [link=xxx,align=left|center|righti,alt=alt_text]
      image::filename[]
    INPUT
    OUTPUT
  end
end
