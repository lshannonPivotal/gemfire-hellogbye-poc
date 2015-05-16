<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output omit-xml-declaration="yes"/>

<xsl:template match="/">
  <xsl:for-each select="*//disk-dirs">
      <xsl:value-of select="."/>
  </xsl:for-each>
</xsl:template>
</xsl:stylesheet>      

