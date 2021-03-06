require "spec_helper"

def text_compare(old_xml, new_xml)
  File.write("#{old_xml}.1", norm(File.read(old_xml, encoding: "utf-8")))
  File.write("#{new_xml}.1", norm(File.read(new_xml, encoding: "utf-8")))
  system("xml2rfc #{old_xml}.1 -o #{old_xml}.txt")
  system("xml2rfc #{new_xml}.1 -o #{new_xml}.txt")
end

def text_compare1(old_xml, new_xml)
  system("xml2rfc #{old_xml} -o #{old_xml}.txt")
  system("xml2rfc #{new_xml} -o #{new_xml}.txt")
end

def norm(text)
  text.gsub(%r{<spanx style="strong">(MUST|MUST NOT|REQUIRED|SHALL|SHALL NOT|SHOULD|SHOULD NOT|NOT RECOMMENDED|RECOMMENDED|MAY|OPTIONAL)</spanx>}, "\\1").
    gsub(%r{<t hangText="([^"]+:) ">}, %q{<t hangText="\\1">})
end

def remove_pages(text)
  text.gsub(%r{\n+\S+     [^\n]+\[Page \d+\]\n.?\nRFC[^\n]+\n}, "\n").gsub(%r{\n\n\n+}, "\n\n")
end

def text_compare2(old_xml, new_xml)
  File.write("#{old_xml}.1", norm(File.read(old_xml, encoding: "utf-8")))
  File.write("#{new_xml}.1", norm(File.read(new_xml, encoding: "utf-8")))
  system("xml2rfc #{old_xml}.1 -o #{old_xml}.txt.1")
  system("xml2rfc #{new_xml}.1 -o #{new_xml}.txt.1")
  File.write("#{old_xml}.txt", remove_pages(File.read("#{old_xml}.txt.1", encoding: "utf-8")))
  File.write("#{new_xml}.txt", remove_pages(File.read("#{new_xml}.txt.1", encoding: "utf-8")))
end

describe Asciidoctor::RFC::V2::Converter do
  it "processes RFC 6350 RFC XML v2 example with bibliography preprocessing, with equivalent text" do
    system("asciidoctor -b rfc2 -r 'asciidoctor-bibliography' -r 'asciidoctor-rfc' ./spec/examples/rfc6350.adoc -o spec/examples/rfc6350.xml")
    text_compare2("spec/examples/rfc6350.xml", "spec/examples/rfc6350.xml")
    expect(File.read("spec/examples/rfc6350.xml.txt")).to be_equivalent_to File.read("spec/examples/rfc6350.txt.orig")
  end
  it "processes Davies template with equivalent text" do
    system("bin/asciidoctor-rfc2 spec/examples/davies-template-bare-06.adoc")
    text_compare("spec/examples/davies-template-bare-06.xml.orig", "spec/examples/davies-template-bare-06.xml")
    expect(norm(File.read("spec/examples/davies-template-bare-06.xml.orig.txt"))).to be_equivalent_to norm(File.read("spec/examples/davies-template-bare-06.xml.txt"))
  end
  it "processes MIB template with equivalent text" do
    system("bin/asciidoctor-rfc2 spec/examples/mib-doc-template-xml-06.adoc")
    text_compare("spec/examples/mib-doc-template-xml-06.xml.orig", "spec/examples/mib-doc-template-xml-06.xml")
    expect(norm(File.read("spec/examples/mib-doc-template-xml-06.xml.orig.txt"))).to be_equivalent_to norm(File.read("spec/examples/mib-doc-template-xml-06.xml.txt"))
  end
  it "processes rfc1149 from Markdown with equivalent text" do
    # leaving out step of running ./mmark
    system("bin/asciidoctor-rfc2 spec/examples/rfc1149.md.adoc")
    text_compare("spec/examples/rfc1149.md.2.xml", "spec/examples/rfc1149.md.xml")
    expect(norm(File.read("spec/examples/rfc1149.md.2.xml.txt"))).to be_equivalent_to norm(File.read("spec/examples/rfc1149.md.xml.txt"))
  end
  it "processes rfc2100 from Markdown with equivalent text" do
    # leaving out step of running ./mmark
    system("bin/asciidoctor-rfc2 spec/examples/rfc2100.md.adoc")
    text_compare("spec/examples/rfc2100.md.2.xml", "spec/examples/rfc2100.md.xml")
    expect(norm(File.read("spec/examples/rfc2100.md.2.xml.txt"))).to be_equivalent_to norm(File.read("spec/examples/rfc2100.md.xml.txt"))
  end
  it "processes rfc3514 from Markdown with equivalent text" do
    # leaving out step of running ./mmark
    system("bin/asciidoctor-rfc2 spec/examples/rfc3514.md.adoc")
    text_compare("spec/examples/rfc3514.md.2.xml", "spec/examples/rfc3514.md.xml")
    expect(norm(File.read("spec/examples/rfc3514.md.2.xml.txt"))).to be_equivalent_to norm(File.read("spec/examples/rfc3514.md.xml.txt"))
  end
  it "processes rfc5841 from Markdown with equivalent text" do
    # leaving out step of running ./mmark
    system("bin/asciidoctor-rfc2 spec/examples/rfc5841.md.adoc")
    text_compare("spec/examples/rfc5841.md.2.xml", "spec/examples/rfc5841.md.xml")
    expect(norm(File.read("spec/examples/rfc5841.md.2.xml.txt"))).to be_equivalent_to norm(File.read("spec/examples/rfc5841.md.xml.txt"))
  end
  it "processes rfc748 from Markdown with equivalent text" do
    # leaving out step of running ./mmark
    system("bin/asciidoctor-rfc2 spec/examples/rfc748.md.adoc")
    text_compare("spec/examples/rfc748.md.2.xml", "spec/examples/rfc748.md.xml")
    expect(norm(File.read("spec/examples/rfc748.md.2.xml.txt"))).to be_equivalent_to norm(File.read("spec/examples/rfc748.md.xml.txt"))
  end
  it "processes rfc7511 from Markdown with equivalent text" do
    # leaving out step of running ./mmark
    system("bin/asciidoctor-rfc2 spec/examples/rfc7511.md.adoc")
    text_compare("spec/examples/rfc7511.md.2.xml", "spec/examples/rfc7511.md.xml")
    expect(norm(File.read("spec/examples/rfc7511.md.2.xml.txt"))).to be_equivalent_to norm(File.read("spec/examples/rfc7511.md.xml.txt"))
  end
  it "processes draft-ietf-core-block-xx from Kramdown with equivalent text" do
    # leaving out step of running ./kramdown
    system("bin/asciidoctor-rfc2 spec/examples/draft-ietf-core-block-xx.mkd.adoc")
    text_compare("spec/examples/draft-ietf-core-block-xx.xml.orig", "spec/examples/draft-ietf-core-block-xx.mkd.xml")
    expect(norm(File.read("spec/examples/draft-ietf-core-block-xx.xml.orig.txt"))).to be_equivalent_to norm(File.read("spec/examples/draft-ietf-core-block-xx.mkd.xml.txt"))
  end
  it "processes skel from Kramdown with equivalent text" do
    # leaving out step of running ./kramdown
    system("bin/asciidoctor-rfc2 spec/examples/skel.mkd.adoc")
    text_compare1("spec/examples/skel.xml.orig", "spec/examples/skel.mkd.xml")
    expect(File.read("spec/examples/skel.xml.orig.txt")).to be_equivalent_to File.read("spec/examples/skel.mkd.xml.txt")
  end
  it "processes stupid-s from Kramdown with equivalent text" do
    # leaving out step of running ./kramdown
    system("bin/asciidoctor-rfc2 spec/examples/stupid-s.mkd.adoc")
    text_compare("spec/examples/stupid-s.xml.orig", "spec/examples/stupid-s.mkd.xml")
    expect(File.read("spec/examples/stupid-s.xml.orig.txt")).to be_equivalent_to File.read("spec/examples/stupid-s.mkd.xml.txt")
  end
  it "processes Hoffman RFC XML v2 example with equivalent text" do
    system("bin/asciidoctor-rfc2 spec/examples/hoffmanv2.xml.adoc")
    text_compare("spec/examples/hoffmanv2.xml.orig", "spec/examples/hoffmanv2.xml.xml")
    expect(norm(File.read("spec/examples/hoffmanv2.xml.orig.txt"))).to be_equivalent_to norm(File.read("spec/examples/hoffmanv2.xml.xml.txt"))
  end
  it "processes draft-iab-rfc-framework-bis RFC XML v2 example with equivalent text" do
    system("bin/asciidoctor-rfc2 spec/examples/draft-iab-rfc-framework-bis.xml.adoc")
    text_compare("spec/examples/draft-iab-rfc-framework-bis.xml.orig", "spec/examples/draft-iab-rfc-framework-bis.xml.xml")
    expect(norm(File.read("spec/examples/draft-iab-rfc-framework-bis.xml.orig.txt"))).to be_equivalent_to norm(File.read("spec/examples/draft-iab-rfc-framework-bis.xml.xml.txt"))
  end
  it "processes draft-iab-html-rfc-bis RFC XML v2 example with equivalent text" do
    system("bin/asciidoctor-rfc2 spec/examples/draft-iab-html-rfc-bis.xml.adoc")
    text_compare("spec/examples/draft-iab-html-rfc-bis.xml.orig", "spec/examples/draft-iab-html-rfc-bis.xml.xml")
    expect(norm(File.read("spec/examples/draft-iab-html-rfc-bis.xml.orig.txt"))).to be_equivalent_to norm(File.read("spec/examples/draft-iab-html-rfc-bis.xml.xml.txt"))
  end
end
