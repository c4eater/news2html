<?xml version="1.0" ?>

<!--
This template transforms the contents of an XHTML article on habrahabr.ru
and geektimes.ru into a stripped-down HTML version that includes only the
<div> blocks containing the article and comments. 

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
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- print everything below /html/head/title -->
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


<!-- process everything below /html/body -->
<xsl:template match="/html/body//*">
    <xsl:apply-templates select="*"/>
</xsl:template>


<!-- print article div -->
<xsl:template match="/html/body//div[contains(@class,'post__text')]">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- print everything inside article div -->
<xsl:template match="/html/body//div[contains(@class,'post__text')]//node()">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- print comments div -->
<xsl:template match="/html/body//ul[@id='comments-list']">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- print everything inside comments div -->
<xsl:template match="/html/body//ul[@id='comments-list']//node()">
    <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()"/>
    </xsl:copy>
</xsl:template>


<!-- don't print JS -->
<xsl:template match="script|noscript"/>


<!-- don't print avatar icons -->
<xsl:template match="img[starts-with(@class, 'user-info')]"/>


<!-- don't print controls -->
<xsl:template match="ul[starts-with(@class, 'inline-list ')]"/>
<xsl:template match="div[@class='comment__footer']"/>
<xsl:template match="span[@class='icon_comment-edit']"/>
<xsl:template match="span[starts-with(@class, 'default-image')]"/>


<!-- completely suppress the voting div -->
<!--xsl:template match="div[starts-with(@class, 'voting')]"/-->


<!-- don't print the voting controls -->
<xsl:template match="div[starts-with(@class, 'voting')]/button"/>
<xsl:template match="div[starts-with(@class, 'voting')]/svg"/>

</xsl:stylesheet>
