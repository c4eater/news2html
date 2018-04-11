<?xml version="1.0" ?>

<!--
This template transforms the contents of an XHTML Slashdot article (with
comments) into a stripped-down HTML version that includes only the <div> 
blocks containing the article and comments. 

In other words, the following is stripped off:

  - controls (eg. reply buttons)
  - <script> and <noscript>
  - ad blocks
  - social buttons
  - CSS

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- suppress everything by default -->
<xsl:template match="comment()|text()|@*"/>


<!-- process /html/head/title -->
<xsl:template match="/html|/html/head|/html/head/title">
    <xsl:copy>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- print everything inside /html/head/title -->
<xsl:template match="/html/head/title//node()">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- process /html/body -->
<xsl:template match="/html/body">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- process everything inside /html/body -->
<xsl:template match="/html/body//*">
    <xsl:apply-templates select="*"/>
</xsl:template>


<!-- print article div -->
<xsl:template match="/html/body//div[@class='body']">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- print everything inside article div -->
<xsl:template match="/html/body//div[@class='body']//node()">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- print comments div -->
<xsl:template match="/html/body//ul[@id='commentlisting']">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- print everything inside comments div -->
<xsl:template match="/html/body//ul[@id='commentlisting']//node()">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- decorate quoting -->
<xsl:template match="div[@class='quote']">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:element name="blockquote">
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:copy>
</xsl:template>


<!-- don't print JS and controls -->
<xsl:template match="script|noscript"/>
<xsl:template match="div[starts-with(@id,'replyto_')]"/>
<xsl:template match="div[@class='commentSub']"/>
<xsl:template match="li[@class='hide']"/>


</xsl:stylesheet>
