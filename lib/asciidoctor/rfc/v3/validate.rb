require "nokogiri"

module Asciidoctor
  module RFC::V3
    module Validate
      class << self
        def validate(doc)
          schemadoc = relaxng()
          schema = Nokogiri::XML::RelaxNG(schemadoc)
          schema.validate(Nokogiri::XML(doc)).each do |error|
            puts "RELAXNG Validation: #{error.message}"
          end
        end

        def relaxng
          svg_location = File.join(File.dirname(__FILE__), "svg.rng")
          <<RELAXNG
            <?xml version="1.0" encoding="UTF-8"?>
            <grammar xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0" xmlns="http://relaxng.org/ns/structure/1.0" datatypeLibrary="http://www.w3.org/2001/XMLSchema-datatypes">
              <!-- xml2rfc Version 3 grammar -->
              <define name="rfc">
                <element name="rfc">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="number"/>
                  </optional>
                  <optional>
                    <attribute name="obsoletes" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="updates" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="category"/>
                  </optional>
                  <optional>
                    <attribute name="mode"/>
                  </optional>
                  <optional>
                    <attribute name="consensus" a:defaultValue="false">
                      <choice>
                        <value>no</value>
                        <value>yes</value>
                        <value>false</value>
                        <value>true</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="seriesNo"/>
                  </optional>
                  <optional>
                    <attribute name="ipr"/>
                  </optional>
                  <optional>
                    <attribute name="iprExtract">
                      <data type="IDREF"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="submissionType" a:defaultValue="IETF">
                      <choice>
                        <value>IETF</value>
                        <value>IAB</value>
                        <value>IRTF</value>
                        <value>independent</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="docName"/>
                  </optional>
                  <optional>
                    <attribute name="sortRefs" a:defaultValue="false">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="symRefs" a:defaultValue="true">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="tocInclude" a:defaultValue="true">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="tocDepth" a:defaultValue="3"/>
                  </optional>
                  <optional>
                    <attribute name="prepTime"/>
                  </optional>
                  <optional>
                    <attribute name="indexInclude" a:defaultValue="true">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="version"/>
                  </optional>
                  <optional>
                    <attribute name="scripts" a:defaultValue="Common,Latin"/>
                  </optional>
                  <optional>
                    <attribute name="expiresDate"/>
                  </optional>
                  <zeroOrMore>
                    <ref name="link"/>
                  </zeroOrMore>
                  <ref name="front"/>
                  <ref name="middle"/>
                  <optional>
                    <ref name="back"/>
                  </optional>
                </element>
              </define>
              <define name="link">
                <element name="link">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="href"/>
                  <optional>
                    <attribute name="rel"/>
                  </optional>
                </element>
              </define>
              <define name="front">
                <element name="front">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <ref name="title"/>
                  <zeroOrMore>
                    <ref name="seriesInfo"/>
                  </zeroOrMore>
                  <oneOrMore>
                    <ref name="author"/>
                  </oneOrMore>
                  <optional>
                    <ref name="date"/>
                  </optional>
                  <zeroOrMore>
                    <ref name="area"/>
                  </zeroOrMore>
                  <zeroOrMore>
                    <ref name="workgroup"/>
                  </zeroOrMore>
                  <zeroOrMore>
                    <ref name="keyword"/>
                  </zeroOrMore>
                  <optional>
                    <ref name="abstract"/>
                  </optional>
                  <zeroOrMore>
                    <ref name="note"/>
                  </zeroOrMore>
                  <optional>
                    <ref name="boilerplate"/>
                  </optional>
                </element>
              </define>
              <define name="title">
                <element name="title">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="abbrev"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="author">
                <element name="author">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="initials"/>
                  </optional>
                  <optional>
                    <attribute name="asciiInitials"/>
                  </optional>
                  <optional>
                    <attribute name="surname"/>
                  </optional>
                  <optional>
                    <attribute name="asciiSurname"/>
                  </optional>
                  <optional>
                    <attribute name="fullname"/>
                  </optional>
                  <optional>
                    <attribute name="role">
                      <value>editor</value>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="asciiFullname"/>
                  </optional>
                  <optional>
                    <ref name="organization"/>
                  </optional>
                  <optional>
                    <ref name="address"/>
                  </optional>
                </element>
              </define>
              <define name="organization">
                <element name="organization">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="abbrev"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="address">
                <element name="address">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <ref name="postal"/>
                  </optional>
                  <optional>
                    <ref name="phone"/>
                  </optional>
                  <optional>
                    <ref name="facsimile"/>
                  </optional>
                  <optional>
                    <ref name="email"/>
                  </optional>
                  <optional>
                    <ref name="uri"/>
                  </optional>
                </element>
              </define>
              <define name="postal">
                <element name="postal">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <choice>
                    <zeroOrMore>
                      <choice>
                        <ref name="city"/>
                        <ref name="code"/>
                        <ref name="country"/>
                        <ref name="region"/>
                        <ref name="street"/>
                      </choice>
                    </zeroOrMore>
                    <oneOrMore>
                      <ref name="postalLine"/>
                    </oneOrMore>
                  </choice>
                </element>
              </define>
              <define name="street">
                <element name="street">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="city">
                <element name="city">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="region">
                <element name="region">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="code">
                <element name="code">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="country">
                <element name="country">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="postalLine">
                <element name="postalLine">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="phone">
                <element name="phone">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="facsimile">
                <element name="facsimile">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="email">
                <element name="email">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="ascii"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="uri">
                <element name="uri">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="date">
                <element name="date">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="day"/>
                  </optional>
                  <optional>
                    <attribute name="month"/>
                  </optional>
                  <optional>
                    <attribute name="year"/>
                  </optional>
                  <empty/>
                </element>
              </define>
              <define name="area">
                <element name="area">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="workgroup">
                <element name="workgroup">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="keyword">
                <element name="keyword">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="abstract">
                <element name="abstract">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <oneOrMore>
                    <choice>
                      <ref name="dl"/>
                      <ref name="ol"/>
                      <ref name="t"/>
                      <ref name="ul"/>
                    </choice>
                  </oneOrMore>
                </element>
              </define>
              <define name="note">
                <element name="note">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="title"/>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <attribute name="removeInRFC" a:defaultValue="false">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <ref name="name"/>
                  </optional>
                  <oneOrMore>
                    <choice>
                      <ref name="dl"/>
                      <ref name="ol"/>
                      <ref name="t"/>
                      <ref name="ul"/>
                    </choice>
                  </oneOrMore>
                </element>
              </define>
              <define name="boilerplate">
                <element name="boilerplate">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <oneOrMore>
                    <ref name="section"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="middle">
                <element name="middle">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <oneOrMore>
                    <ref name="section"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="section">
                <element name="section">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <attribute name="title"/>
                  </optional>
                  <optional>
                    <attribute name="numbered" a:defaultValue="true">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="toc" a:defaultValue="default">
                      <choice>
                        <value>include</value>
                        <value>exclude</value>
                        <value>default</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="removeInRFC" a:defaultValue="false">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <ref name="name"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <ref name="artwork"/>
                      <ref name="aside"/>
                      <ref name="blockquote"/>
                      <ref name="dl"/>
                      <ref name="figure"/>
                      <ref name="iref"/>
                      <ref name="ol"/>
                      <ref name="sourcecode"/>
                      <ref name="t"/>
                      <ref name="table"/>
                      <ref name="texttable"/>
                      <ref name="ul"/>
                    </choice>
                  </zeroOrMore>
                  <zeroOrMore>
                    <ref name="section"/>
                  </zeroOrMore>
                </element>
              </define>
              <define name="name">
                <element name="name">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="slugifiedName"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="cref"/>
                      <ref name="eref"/>
                      <ref name="relref"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="t">
                <element name="t">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <attribute name="hangText"/>
                  </optional>
                  <optional>
                    <attribute name="keepWithNext" a:defaultValue="false">
                      <choice>
                        <value>false</value>
                        <value>true</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="keepWithPrevious" a:defaultValue="false">
                      <choice>
                        <value>false</value>
                        <value>true</value>
                      </choice>
                    </attribute>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="list"/>
                      <ref name="relref"/>
                      <ref name="spanx"/>
                      <ref name="strong"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="tt"/>
                      <ref name="vspace"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="aside">
                <element name="aside">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <ref name="artwork"/>
                      <ref name="dl"/>
                      <ref name="figure"/>
                      <ref name="iref"/>
                      <ref name="list"/>
                      <ref name="ol"/>
                      <ref name="t"/>
                      <ref name="table"/>
                      <ref name="ul"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="blockquote">
                <element name="blockquote">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <attribute name="cite"/>
                  </optional>
                  <optional>
                    <attribute name="quotedFrom"/>
                  </optional>
                  <choice>
                    <oneOrMore>
                      <choice>
                        <ref name="artwork"/>
                        <ref name="dl"/>
                        <ref name="figure"/>
                        <ref name="ol"/>
                        <ref name="sourcecode"/>
                        <ref name="t"/>
                        <ref name="ul"/>
                      </choice>
                    </oneOrMore>
                    <oneOrMore>
                      <choice>
                        <text/>
                        <ref name="bcp14"/>
                        <ref name="cref"/>
                        <ref name="em"/>
                        <ref name="eref"/>
                        <ref name="iref"/>
                        <ref name="relref"/>
                        <ref name="strong"/>
                        <ref name="sub"/>
                        <ref name="sup"/>
                        <ref name="tt"/>
                        <ref name="xref"/>
                      </choice>
                    </oneOrMore>
                  </choice>
                </element>
              </define>
              <define name="list">
                <element name="list">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="style" a:defaultValue="empty"/>
                  </optional>
                  <optional>
                    <attribute name="hangIndent"/>
                  </optional>
                  <optional>
                    <attribute name="counter"/>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <oneOrMore>
                    <ref name="t"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="ol">
                <element name="ol">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="type" a:defaultValue="1"/>
                  </optional>
                  <optional>
                    <attribute name="start" a:defaultValue="1"/>
                  </optional>
                  <optional>
                    <attribute name="group"/>
                  </optional>
                  <optional>
                    <attribute name="spacing" a:defaultValue="normal">
                      <choice>
                        <value>normal</value>
                        <value>compact</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <oneOrMore>
                    <ref name="li"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="ul">
                <element name="ul">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="spacing" a:defaultValue="normal">
                      <choice>
                        <value>normal</value>
                        <value>compact</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="empty" a:defaultValue="false">
                      <choice>
                        <value>false</value>
                        <value>true</value>
                      </choice>
                    </attribute>
                    <optional>
                      <attribute name="pn"/>
                    </optional>
                  </optional>
                  <oneOrMore>
                    <ref name="li"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="li">
                <element name="li">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <choice>
                    <oneOrMore>
                      <choice>
                        <ref name="artwork"/>
                        <ref name="dl"/>
                        <ref name="figure"/>
                        <ref name="ol"/>
                        <ref name="sourcecode"/>
                        <ref name="t"/>
                        <ref name="ul"/>
                      </choice>
                    </oneOrMore>
                    <oneOrMore>
                      <choice>
                        <text/>
                        <ref name="bcp14"/>
                        <ref name="cref"/>
                        <ref name="em"/>
                        <ref name="eref"/>
                        <ref name="iref"/>
                        <ref name="relref"/>
                        <ref name="strong"/>
                        <ref name="sub"/>
                        <ref name="sup"/>
                        <ref name="tt"/>
                        <ref name="xref"/>
                      </choice>
                    </oneOrMore>
                  </choice>
                </element>
              </define>
              <define name="dl">
                <element name="dl">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="spacing" a:defaultValue="normal">
                      <choice>
                        <value>normal</value>
                        <value>compact</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="hanging" a:defaultValue="true">
                      <choice>
                        <value>false</value>
                        <value>true</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <oneOrMore>
                    <ref name="dt"/>
                    <ref name="dd"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="dt">
                <element name="dt">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="relref"/>
                      <ref name="strong"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="dd">
                <element name="dd">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <choice>
                    <oneOrMore>
                      <choice>
                        <ref name="artwork"/>
                        <ref name="dl"/>
                        <ref name="figure"/>
                        <ref name="ol"/>
                        <ref name="sourcecode"/>
                        <ref name="t"/>
                        <ref name="ul"/>
                      </choice>
                    </oneOrMore>
                    <oneOrMore>
                      <choice>
                        <text/>
                        <ref name="bcp14"/>
                        <ref name="cref"/>
                        <ref name="em"/>
                        <ref name="eref"/>
                        <ref name="iref"/>
                        <ref name="relref"/>
                        <ref name="strong"/>
                        <ref name="sub"/>
                        <ref name="sup"/>
                        <ref name="tt"/>
                        <ref name="xref"/>
                      </choice>
                    </oneOrMore>
                  </choice>
                </element>
              </define>
              <define name="xref">
                <element name="xref">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="target">
                    <data type="IDREF"/>
                  </attribute>
                  <optional>
                    <attribute name="pageno" a:defaultValue="false">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="format" a:defaultValue="default">
                      <choice>
                        <value>default</value>
                        <value>title</value>
                        <value>counter</value>
                        <value>none</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="derivedContent"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="relref">
                <element name="relref">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="target">
                    <data type="IDREF"/>
                  </attribute>
                  <optional>
                    <attribute name="displayFormat" a:defaultValue="of">
                      <choice>
                        <value>of</value>
                        <value>comma</value>
                        <value>parens</value>
                        <value>bare</value>
                      </choice>
                    </attribute>
                  </optional>
                  <attribute name="section"/>
                  <optional>
                    <attribute name="relative"/>
                  </optional>
                  <optional>
                    <attribute name="derivedLink"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="eref">
                <element name="eref">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="target"/>
                  <text/>
                </element>
              </define>
              <define name="iref">
                <element name="iref">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="item"/>
                  <optional>
                    <attribute name="subitem" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="primary" a:defaultValue="false">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <empty/>
                </element>
              </define>
              <define name="cref">
                <element name="cref">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="source"/>
                  </optional>
                  <optional>
                    <attribute name="display" a:defaultValue="true">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="relref"/>
                      <ref name="strong"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="tt">
                <element name="tt">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="relref"/>
                      <ref name="strong"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="strong">
                <element name="strong">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="relref"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="em">
                <element name="em">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="relref"/>
                      <ref name="strong"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="sub">
                <element name="sub">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="relref"/>
                      <ref name="strong"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="sup">
                <element name="sup">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="relref"/>
                      <ref name="strong"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="spanx">
                <element name="spanx">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="xml:space" a:defaultValue="preserve">
                      <choice>
                        <value>default</value>
                        <value>preserve</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="style" a:defaultValue="emph"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="vspace">
                <element name="vspace">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="blankLines" a:defaultValue="0"/>
                  </optional>
                  <empty/>
                </element>
              </define>
              <define name="figure">
                <element name="figure">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <attribute name="title" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="suppress-title" a:defaultValue="false">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="src"/>
                  </optional>
                  <optional>
                    <attribute name="originalSrc"/>
                  </optional>
                  <optional>
                    <attribute name="align" a:defaultValue="left">
                      <choice>
                        <value>left</value>
                        <value>center</value>
                        <value>right</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="alt" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="width" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="height" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <ref name="name"/>
                  </optional>
                  <zeroOrMore>
                    <ref name="iref"/>
                  </zeroOrMore>
                  <optional>
                    <ref name="preamble"/>
                  </optional>
                  <oneOrMore>
                    <choice>
                      <ref name="artwork"/>
                      <ref name="sourcecode"/>
                    </choice>
                  </oneOrMore>
                  <optional>
                    <ref name="postamble"/>
                  </optional>
                </element>
              </define>
              <define name="table">
                <element name="table">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <ref name="name"/>
                  </optional>
                  <zeroOrMore>
                    <ref name="iref"/>
                  </zeroOrMore>
                  <optional>
                    <ref name="thead"/>
                  </optional>
                  <oneOrMore>
                    <ref name="tbody"/>
                  </oneOrMore>
                  <optional>
                    <ref name="tfoot"/>
                  </optional>
                </element>
              </define>
              <define name="preamble">
                <element name="preamble">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="relref"/>
                      <ref name="spanx"/>
                      <ref name="strong"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="artwork">
                <element name="artwork">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <attribute name="xml:space"/>
                  </optional>
                  <optional>
                    <attribute name="name" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="type" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="src"/>
                  </optional>
                  <optional>
                    <attribute name="align" a:defaultValue="left">
                      <choice>
                        <value>left</value>
                        <value>center</value>
                        <value>right</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="alt" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="width" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="height" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="originalSrc"/>
                  </optional>
                  <choice>
                    <zeroOrMore>
                      <text/>
                    </zeroOrMore>
                    <externalRef href="#{svg_location}"/>
                    <!--<ref name="svg"/>-->
                  </choice>
                </element>
              </define>
              <!-- https://www.rfc-editor.org/materials/format/SVG-1.2-RFC.rnc -->
              <define name="sourcecode">
                <element name="sourcecode">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <attribute name="name" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="type" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="src"/>
                  </optional>
                  <optional>
                    <attribute name="originalSrc"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="thead">
                <element name="thead">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <oneOrMore>
                    <ref name="tr"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="tbody">
                <element name="tbody">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <oneOrMore>
                    <ref name="tr"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="tfoot">
                <element name="tfoot">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <oneOrMore>
                    <ref name="tr"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="tr">
                <element name="tr">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <oneOrMore>
                    <choice>
                      <ref name="td"/>
                      <ref name="th"/>
                    </choice>
                  </oneOrMore>
                </element>
              </define>
              <define name="td">
                <element name="td">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="colspan" a:defaultValue="0"/>
                  </optional>
                  <optional>
                    <attribute name="rowspan" a:defaultValue="0"/>
                  </optional>
                  <optional>
                    <attribute name="align" a:defaultValue="left">
                      <choice>
                        <value>left</value>
                        <value>center</value>
                        <value>right</value>
                      </choice>
                    </attribute>
                  </optional>
                  <choice>
                    <oneOrMore>
                      <choice>
                        <ref name="artwork"/>
                        <ref name="dl"/>
                        <ref name="figure"/>
                        <ref name="ol"/>
                        <ref name="sourcecode"/>
                        <ref name="t"/>
                        <ref name="ul"/>
                      </choice>
                    </oneOrMore>
                    <zeroOrMore>
                      <choice>
                        <text/>
                        <ref name="bcp14"/>
                        <ref name="br"/>
                        <ref name="cref"/>
                        <ref name="em"/>
                        <ref name="eref"/>
                        <ref name="iref"/>
                        <ref name="relref"/>
                        <ref name="strong"/>
                        <ref name="sub"/>
                        <ref name="sup"/>
                        <ref name="tt"/>
                        <ref name="xref"/>
                      </choice>
                    </zeroOrMore>
                  </choice>
                </element>
              </define>
              <define name="th">
                <element name="th">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="colspan" a:defaultValue="0"/>
                  </optional>
                  <optional>
                    <attribute name="rowspan" a:defaultValue="0"/>
                  </optional>
                  <optional>
                    <attribute name="align" a:defaultValue="left">
                      <choice>
                        <value>left</value>
                        <value>center</value>
                        <value>right</value>
                      </choice>
                    </attribute>
                  </optional>
                  <choice>
                    <oneOrMore>
                      <choice>
                        <ref name="artwork"/>
                        <ref name="dl"/>
                        <ref name="figure"/>
                        <ref name="ol"/>
                        <ref name="sourcecode"/>
                        <ref name="t"/>
                        <ref name="ul"/>
                      </choice>
                    </oneOrMore>
                    <zeroOrMore>
                      <choice>
                        <text/>
                        <ref name="bcp14"/>
                        <ref name="br"/>
                        <ref name="cref"/>
                        <ref name="em"/>
                        <ref name="eref"/>
                        <ref name="iref"/>
                        <ref name="relref"/>
                        <ref name="strong"/>
                        <ref name="sub"/>
                        <ref name="sup"/>
                        <ref name="tt"/>
                        <ref name="xref"/>
                      </choice>
                    </zeroOrMore>
                  </choice>
                </element>
              </define>
              <define name="postamble">
                <element name="postamble">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="cref"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="spanx"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="texttable">
                <element name="texttable">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="title" a:defaultValue=""/>
                  </optional>
                  <optional>
                    <attribute name="suppress-title" a:defaultValue="false">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="align" a:defaultValue="center">
                      <choice>
                        <value>left</value>
                        <value>center</value>
                        <value>right</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="style" a:defaultValue="full">
                      <choice>
                        <value>all</value>
                        <value>none</value>
                        <value>headers</value>
                        <value>full</value>
                      </choice>
                    </attribute>
                  </optional>
                  <optional>
                    <ref name="name"/>
                  </optional>
                  <optional>
                    <ref name="preamble"/>
                  </optional>
                  <oneOrMore>
                    <ref name="ttcol"/>
                  </oneOrMore>
                  <zeroOrMore>
                    <ref name="c"/>
                  </zeroOrMore>
                  <optional>
                    <ref name="postamble"/>
                  </optional>
                </element>
              </define>
              <define name="ttcol">
                <element name="ttcol">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="width"/>
                  </optional>
                  <optional>
                    <attribute name="align" a:defaultValue="left">
                      <choice>
                        <value>left</value>
                        <value>center</value>
                        <value>right</value>
                      </choice>
                    </attribute>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <ref name="cref"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="xref"/>
                      <text/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="c">
                <element name="c">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="cref"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="spanx"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="bcp14">
                <element name="bcp14">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <text/>
                </element>
              </define>
              <define name="br">
                <element name="br">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <empty/>
                </element>
              </define>
              <define name="back">
                <element name="back">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <ref name="displayreference"/>
                  </zeroOrMore>
                  <zeroOrMore>
                    <ref name="references"/>
                  </zeroOrMore>
                  <zeroOrMore>
                    <ref name="section"/>
                  </zeroOrMore>
                </element>
              </define>
              <define name="displayreference">
                <element name="displayreference">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="target">
                    <data type="IDREF"/>
                  </attribute>
                  <attribute name="to"/>
                </element>
              </define>
              <define name="references">
                <element name="references">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="pn"/>
                  </optional>
                  <optional>
                    <attribute name="anchor">
                      <data type="ID"/>
                    </attribute>
                  </optional>
                  <optional>
                    <attribute name="title"/>
                  </optional>
                  <optional>
                    <ref name="name"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <ref name="reference"/>
                      <ref name="referencegroup"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="reference">
                <element name="reference">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="anchor">
                    <data type="ID"/>
                  </attribute>
                  <optional>
                    <attribute name="target"/>
                  </optional>
                  <optional>
                    <attribute name="quoteTitle" a:defaultValue="true">
                      <choice>
                        <value>true</value>
                        <value>false</value>
                      </choice>
                    </attribute>
                  </optional>
                  <ref name="front"/>
                  <zeroOrMore>
                    <choice>
                      <ref name="annotation"/>
                      <ref name="format"/>
                      <ref name="refcontent"/>
                      <ref name="seriesInfo"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="referencegroup">
                <element name="referencegroup">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="anchor">
                    <data type="ID"/>
                  </attribute>
                  <oneOrMore>
                    <ref name="reference"/>
                  </oneOrMore>
                </element>
              </define>
              <define name="seriesInfo">
                <element name="seriesInfo">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <attribute name="name"/>
                  <attribute name="value"/>
                  <optional>
                    <attribute name="asciiName"/>
                  </optional>
                  <optional>
                    <attribute name="asciiValue"/>
                  </optional>
                  <optional>
                    <attribute name="status"/>
                  </optional>
                  <optional>
                    <attribute name="stream" a:defaultValue="IETF">
                      <choice>
                        <value>IETF</value>
                        <value>IAB</value>
                        <value>IRTF</value>
                        <value>independent</value>
                      </choice>
                    </attribute>
                  </optional>
                  <empty/>
                </element>
              </define>
              <define name="format">
                <element name="format">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <optional>
                    <attribute name="target"/>
                  </optional>
                  <attribute name="type"/>
                  <optional>
                    <attribute name="octets"/>
                  </optional>
                  <empty/>
                </element>
              </define>
              <define name="annotation">
                <element name="annotation">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="cref"/>
                      <ref name="em"/>
                      <ref name="eref"/>
                      <ref name="iref"/>
                      <ref name="relref"/>
                      <ref name="spanx"/>
                      <ref name="strong"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="tt"/>
                      <ref name="xref"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <define name="refcontent">
                <element name="refcontent">
                  <optional>
                    <attribute name="xml:base"/>
                  </optional>
                  <optional>
                    <attribute name="xml:lang"/>
                  </optional>
                  <zeroOrMore>
                    <choice>
                      <text/>
                      <ref name="bcp14"/>
                      <ref name="em"/>
                      <ref name="strong"/>
                      <ref name="sub"/>
                      <ref name="sup"/>
                      <ref name="tt"/>
                    </choice>
                  </zeroOrMore>
                </element>
              </define>
              <start combine="choice">
                <ref name="rfc"/>
              </start>
            </grammar>
RELAXNG
        end
      end
    end
  end
end
