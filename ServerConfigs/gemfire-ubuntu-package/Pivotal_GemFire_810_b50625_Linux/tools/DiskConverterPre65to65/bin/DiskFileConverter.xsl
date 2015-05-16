<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="/">
  <xsl:apply-templates select="cache|client-cache"/>
</xsl:template>

<xsl:template match="cache|client-cache">
  <xsl:copy>
    <xsl:copy-of select="disk-store"/>
    <xsl:apply-templates select="region-attributes|vm-root-region|region|gateway-hub"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="region-attributes">
  <xsl:copy>
    <xsl:copy-of select="@data-policy|@id|@persist-backup|@disk-store-name|@disk-synchronous|@refid|@scope"/>
    <xsl:copy-of select="disk-write-attributes|disk-dirs|partition-attributes|eviction-attributes"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="gateway-hub[gateway/gateway-queue/@enable-persistence='true']">
  <xsl:variable name="hubid">
    <xsl:value-of select="@id"/>
  </xsl:variable>

  <xsl:for-each select="gateway">
  <xsl:element name="region">
    <xsl:attribute name="name"><xsl:copy-of select="$hubid"/>_<xsl:value-of select="@id"/>_EVENT_QUEUE</xsl:attribute>
    <xsl:apply-templates select="gateway-queue"/>
  </xsl:element>
  </xsl:for-each>
</xsl:template>

<xsl:template match="vm-root-region|region">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates select="region-attributes|region"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="gateway-queue[@disk-store-name]">
  <xsl:attribute-set name="ra_list">
    <xsl:attribute name="scope">distributed-no-ack</xsl:attribute>
    <xsl:attribute name="data-policy">persistent-replicate</xsl:attribute>
    <xsl:attribute name="disk-store-name"><xsl:value-of select="@disk-store-name"/></xsl:attribute>
  </xsl:attribute-set>

  <xsl:element name="region-attributes" use-attribute-sets="ra_list"/>
</xsl:template>

<xsl:template match="gateway-queue[@overflow-directory]">
    <region-attributes scope="distributed-no-ack"
     data-policy="persistent-replicate">
        <disk-dirs>
          <disk-dir>
            <xsl:value-of select="@overflow-directory"/>
          </disk-dir>
        </disk-dirs>
    </region-attributes>
</xsl:template>

</xsl:stylesheet>      

