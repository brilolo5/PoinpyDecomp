varying vec2 tex_baseCoord ;
uniform sampler2D gm_maskTexture ;
uniform vec4 uv_baseTex ;
uniform vec4 uv_maskTex ;
uniform vec2 size_baseTex ;
uniform vec2 size_maskTex ;
uniform vec2 xy_maskTex ;
uniform vec2 sizeTex_baseTex ;
uniform vec2 sizeTex_maskTex ;
vec2 maskCoord() {
	
	vec2 size_ratio = size_maskTex/size_baseTex ;
	
	vec2 offsetStart_baseTex = vec2( uv_baseTex.r , uv_baseTex.g ) ;
	vec2 offsetStart_maskTex = vec2( uv_maskTex.r , uv_maskTex.g ) ;
	offsetStart_baseTex = offsetStart_baseTex*sizeTex_baseTex ;
	offsetStart_maskTex = offsetStart_maskTex*sizeTex_maskTex ;
	//vec2 offsetEnd_baseTex   = vec2( uv_baseTex.b , uv_baseTex.a ) ; //not used
	//vec2 offsetEnd_maskTex   = vec2( uv_maskTex.b , uv_maskTex.a ) ;
	
	vec2 uvLen_baseTex = vec2( uv_baseTex.b-uv_baseTex.r , uv_baseTex.a-uv_baseTex.g ) ;
	vec2 uvLen_maskTex = vec2( uv_maskTex.b-uv_maskTex.r , uv_maskTex.a-uv_maskTex.g ) ;
	uvLen_baseTex = uvLen_baseTex*sizeTex_baseTex ;
	uvLen_maskTex = uvLen_maskTex*sizeTex_maskTex ;
	
	vec2 tex_maskCoord = 
	( (tex_baseCoord - offsetStart_baseTex )*(uvLen_maskTex / uvLen_baseTex)/size_ratio ) + offsetStart_maskTex
	-xy_maskTex*uvLen_baseTex/size_baseTex*uvLen_maskTex/uvLen_baseTex/size_ratio ;
	
	return tex_maskCoord ;
}
void main() {
	vec2 tex_maskCoord = maskCoord() ;
	vec4 tex_result = vec4( 0 , 0 , 0 , 0 ) ;
	vec4 tex_base = texture2D( gm_BaseTexture , tex_baseCoord ) ;
	vec4 tex_mask = texture2D( gm_maskTexture , tex_maskCoord ) ;
	tex_mask.a = tex_mask.a*ceil(tex_base.a)  ;
	tex_base.a = tex_base.a*ceil(tex_mask.a)  ;
	vec3 tex_base_alp = vec3( tex_base.a , tex_base.a , tex_base.a ) ;
	vec3 tex_mask_alp = vec3( tex_mask.a , tex_mask.a , tex_mask.a ) ;
	
	if ( ( tex_base.r == 0. ) && ( tex_mask.r == tex_mask.a ) ){
		tex_result.r = tex_base.a * tex_mask.a + tex_mask.r * ( 1. - tex_base.a ) ;
	}
	else if( tex_base.r == 0.0 ) {
		tex_result.r = tex_mask.r * ( 1. - tex_base.a ) ;
	}
	else if ( tex_base.r > 0. ) {
		tex_result.r = tex_base.a * tex_mask.a * 
		( 1. - min( 1.0 , ( 1. - tex_mask.r/tex_mask.a ) * tex_base.a/tex_base.r ))
		+ tex_base.r * ( 1. - tex_mask.a ) + tex_mask.r * (1. - tex_base.a ) ;
	}
	if ( ( tex_base.g == 0. ) && ( tex_mask.g == tex_mask.a ) ){
		tex_result.g = tex_base.a * tex_mask.a + tex_mask.g * ( 1. - tex_base.a ) ;
	}
	else if( tex_base.g == 0.0 ) {
		tex_result.g = tex_mask.g * ( 1. - tex_base.a ) ;
	}
	else if ( tex_base.g > 0. ) {
		tex_result.g = tex_base.a * tex_mask.a * 
		( 1. - min( 1.0 , ( 1. - tex_mask.g/tex_mask.a ) * tex_base.a/tex_base.g ))
		+ tex_base.r * ( 1. - tex_mask.a ) + tex_mask.g * (1. - tex_base.a ) ;
	}
	
	if ( ( tex_base.b == 0. ) && ( tex_mask.b == tex_mask.a ) ){
		tex_result.b = tex_base.a * tex_mask.a + tex_mask.b * ( 1. - tex_base.a ) ;
	}
	else if( tex_base.b == 0.0 ) {
		tex_result.b = tex_mask.b * ( 1. - tex_base.a ) ;
	}
	else if ( tex_base.b > 0. ) {
		tex_result.b = tex_base.a * tex_mask.a * 
		( 1. - min( 1.0 , ( 1. - tex_mask.b/tex_mask.a ) * tex_base.a/tex_base.b ))
		+ tex_base.b * ( 1. - tex_mask.a ) + tex_mask.b * (1. - tex_base.a ) ;
	}
	tex_result.a = tex_base.a + tex_mask.a - tex_base.a * tex_mask.a ;
	/*
	if Sca == 0 and Dca == Da
	  Dca' = Sa × Da + Dca × (1 - Sa)
	otherwise if Sca == 0
	  Dca' = Dca × (1 - Sa)
	otherwise if Sca > 0
	  Dca' = Sa × Da × (1 - min(1, (1 - Dca/Da) × Sa/Sca)) + 
	  Sca × (1 - Da) + Dca × (1 - Sa)
	Da'  = Sa + Da - Sa × Da
	*/
	
    gl_FragColor = tex_result ;
}