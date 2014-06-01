package react;

import haxe.macro.Context;
import haxe.macro.Expr;
using tink.macro.Exprs;
using StringTools;

class ReactMacro {
	macro static public function build():Array<Field> {
		var fields = Context.getBuildFields(),
			cls    = Context.getLocalClass().toString();

		fields.map(function(field) {
			if(field.name == 'new') {
				switch field.kind {
					case FFun({ args: a }) if(a.length > 0):
						throw '$cls: a React class cannot have a constructor with arguments';
					case _:
				}
			}
			switch field.kind {
				case FFun(o):
					o.expr = transformDom(o.expr);
				case _:
			}
		});

        fields.push({
            name: "__init__",
            doc: null,
            meta: [],
            access: [AStatic, APublic],
            kind: FFun({
            	args : [],
            	expr : macro untyped $i{cls} = __js__('
React.createClass((function() {
	var statics = {};
	for(var field in $cls)
		statics[field] = $cls[field];
	var c = new $cls;
	for(var field in $cls.prototype) {
		c[field] = $cls.prototype[field];
	}
	c.statics = statics;
	return c;
})())'),
            	ret : macro : Void
            }),
            pos: Context.currentPos()
        });

        fields.push({
            name: "create",
            doc: null,
            meta: [],
            access: [AStatic, APublic, AInline],
            kind: FFun({
            	args : [{type: macro : Dynamic, name : 'arg'}],
            	expr : macro return untyped __js__('$cls')(arg),
            	ret : macro : ReactComponent
            }),
            pos: Context.currentPos()
        });

		return fields;
	}

	static function transformDom(expr : Expr) {
		return Exprs.transform(expr, function(expr) {
			return switch expr.expr {
				case EMeta(meta, e):
					if(meta.name == 'dom') {
						var code = createDom(e.toString());
						macro (untyped __js__('$code') : react.React.ReactComponent);
					} else {
						expr;
					}
				case _:
					expr;
			}
		});
	}

	static function createDom(code : String) {
		if(!sys.FileSystem.exists('node_modules/react-tools'))
			Sys.command('npm', ['install', 'react-tools']);
		code = '"/** @jsx React.DOM */ ' + code.substr(1, code.length - 2).replace('\\n', ' ').trim() + '"';
		var n = 'process.stdout.write(require("react-tools").transform($code))',
			proc = new sys.io.Process('node', []);
		proc.stdin.writeString(n);
		proc.stdin.close();
		var out = proc.stdout.readAll().toString(),
			err = proc.stderr.readAll().toString();
		proc.close();
		if("" != err)
			throw err;
		return out;
	}

	public static var domTags = "a abbr address area article aside audio b base bdi bdo big blockquote body br
button canvas caption cite code col colgroup data datalist dd del details dfn
div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6
head header hr html i iframe img input ins kbd keygen label legend li link
main map mark menu menuitem meta meter nav noscript object ol optgroup option
output p param pre progress q rp rt ruby s samp script section select small
source span strong style sub summary sup table tbody td textarea tfoot th
thead time title tr track u ul var video wbr circle defs g line linearGradient path polygon polyline radialGradient rect
stop svg text".split(" ");

	public static var domAttributes = "accept accessKey action allowFullScreen allowTransparency alt async
autoComplete autoFocus autoPlay cellPadding cellSpacing charSet checked
className colSpan cols content contentEditable contextMenu controls data
dateTime defer dir disabled draggable encType form formNoValidate frameBorder
height hidden href htmlFor httpEquiv icon id label lang list loop max
maxLength method min multiple name noValidate pattern placeholder poster
preload radioGroup readOnly rel required role rowSpan rows sandbox scope
scrollLeft scrollTop seamless selected size span spellCheck src srcDoc step
style tabIndex target title type value width wmode cx cy d fill fx fy gradientTransform gradientUnits offset points r rx ry
spreadMethod stopColor stopOpacity stroke strokeLinecap strokeWidth textAnchor transform
version viewBox x1 x2 x y1 y2 y".split(" "); // + data-* & aria-*
	// TODO more non standard HTML attrs here http://facebook.github.io/react/docs/special-non-dom-attributes.html
}