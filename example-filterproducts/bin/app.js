(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var App = function() {
	this.products = [{ category : "Sporting Goods", price : "$49.99", stocked : true, name : "Football"},{ category : "Sporting Goods", price : "$9.99", stocked : true, name : "Baseball"},{ category : "Sporting Goods", price : "$29.99", stocked : false, name : "Basketball"},{ category : "Electronics", price : "$99.99", stocked : true, name : "iPod Touch"},{ category : "Electronics", price : "$399.99", stocked : false, name : "iPhone 5"},{ category : "Electronics", price : "$199.99", stocked : true, name : "Nexus 7"}];
};
App.main = function() {
	React.renderComponent(/** @jsx React.DOM */ App(null ),window.document.body);
};
App.create = function(arg) {
	return App(arg);
};
App.__super__ = React;
App.prototype = $extend(React.prototype,{
	render: function() {
		return /** @jsx React.DOM */ React.DOM.div(null,  " ", search.FilterableProductTable(  {products:this.products}), " " );
	}
});
var HxOverrides = function() { };
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Lambda = function() { };
Lambda.iter = function(it,f) {
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		f(x);
	}
};
var search = {};
search.FilterableProductTable = function() { };
search.FilterableProductTable.create = function(arg) {
	return search.FilterableProductTable(arg);
};
search.FilterableProductTable.__super__ = React;
search.FilterableProductTable.prototype = $extend(React.prototype,{
	getInitialState: function() {
		return { filterText : "", inStockOnly : false};
	}
	,handleUserInput: function(filterText,inStockOnly) {
		this.setState({ filterText : filterText, inStockOnly : inStockOnly});
	}
	,render: function() {
		return /** @jsx React.DOM */ React.DOM.div(null,  " ", search.SearchBar(  {filterText:this.state.filterText, inStockOnly:this.state.inStockOnly, onUserInput:this.handleUserInput}     ), " ", search.ProductTable(  {products:   this.props.products,   filterText:this.state.filterText, inStockOnly:this.state.inStockOnly}     ), " " );
	}
});
search.ProductCategoryRow = function() { };
search.ProductCategoryRow.create = function(arg) {
	return search.ProductCategoryRow(arg);
};
search.ProductCategoryRow.__super__ = React;
search.ProductCategoryRow.prototype = $extend(React.prototype,{
	render: function() {
		return /** @jsx React.DOM */ React.DOM.tr(null,  " ", React.DOM.th( {colSpan:"2"}, this.props.category), " " );
	}
});
search.ProductRow = function() { };
search.ProductRow.create = function(arg) {
	return search.ProductRow(arg);
};
search.ProductRow.__super__ = React;
search.ProductRow.prototype = $extend(React.prototype,{
	render: function() {
		var name;
		if(this.props.product.stocked) name = this.props.product.name; else name = /** @jsx React.DOM */ React.DOM.span( {style:  { color: "red" }} , this.props.product.name);
		return /** @jsx React.DOM */ React.DOM.tr(null,  " ", React.DOM.td(null, name), " ", React.DOM.td(null, this.props.product.price), " " );
	}
});
search.ProductTable = function() { };
search.ProductTable.create = function(arg) {
	return search.ProductTable(arg);
};
search.ProductTable.__super__ = React;
search.ProductTable.prototype = $extend(React.prototype,{
	render: function() {
		var _g = this;
		var rows = [];
		var lastCategory = null;
		var products = this.props.products;
		Lambda.iter(products,function(product) {
			if(product.name.indexOf(_g.props.filterText) == -1 || !product.stocked && _g.props.inStockOnly) return;
			if(product.category != lastCategory) rows.push(/** @jsx React.DOM */ search.ProductCategoryRow( {category:product.category, key:product.category} ));
			rows.push(/** @jsx React.DOM */ search.ProductRow( {product:product, key:product.name} ));
			lastCategory = product.category;
		});
		return /** @jsx React.DOM */ React.DOM.table(null,  " ", React.DOM.thead(null,  " ", React.DOM.tr(null,  " ", React.DOM.th(null, "Name"), " ", React.DOM.th(null, "Price"), " " ), " " ), " ", React.DOM.tbody(null, rows), " " );
	}
});
search.SearchBar = function() { };
search.SearchBar.create = function(arg) {
	return search.SearchBar(arg);
};
search.SearchBar.__super__ = React;
search.SearchBar.prototype = $extend(React.prototype,{
	handleChange: function() {
		this.props.onUserInput(this.refs.filterTextInput.getDOMNode().value,this.refs.inStockOnlyInput.getDOMNode().checked);
	}
	,render: function() {
		return /** @jsx React.DOM */ React.DOM.form(null,  " ", React.DOM.input(  {type:  "text",  placeholder:"Search...",  value:this.props.filterText, ref:"filterTextInput", onChange:this.handleChange}     ),  "  ",  React.DOM.p(null,  " ", React.DOM.input(  {type:  "checkbox",  checked:this.props.inStockOnly, ref:"inStockOnlyInput", onChange:this.handleChange}         ), " Only show products in stock " ), " " );
	}
});
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
App = 
					React.createClass((function() {
						var statics = {};
						for(var field in App)
							statics[field] = App[field];
						var c = new App;
						for(var field in App.prototype) {
							c[field] = App.prototype[field];
						}
						c.statics = statics;
						return c;
					})());
search.FilterableProductTable = 
					React.createClass((function() {
						var statics = {};
						for(var field in search.FilterableProductTable)
							statics[field] = search.FilterableProductTable[field];
						var c = new search.FilterableProductTable;
						for(var field in search.FilterableProductTable.prototype) {
							c[field] = search.FilterableProductTable.prototype[field];
						}
						c.statics = statics;
						return c;
					})());
search.ProductCategoryRow = 
					React.createClass((function() {
						var statics = {};
						for(var field in search.ProductCategoryRow)
							statics[field] = search.ProductCategoryRow[field];
						var c = new search.ProductCategoryRow;
						for(var field in search.ProductCategoryRow.prototype) {
							c[field] = search.ProductCategoryRow.prototype[field];
						}
						c.statics = statics;
						return c;
					})());
search.ProductRow = 
					React.createClass((function() {
						var statics = {};
						for(var field in search.ProductRow)
							statics[field] = search.ProductRow[field];
						var c = new search.ProductRow;
						for(var field in search.ProductRow.prototype) {
							c[field] = search.ProductRow.prototype[field];
						}
						c.statics = statics;
						return c;
					})());
search.ProductTable = 
					React.createClass((function() {
						var statics = {};
						for(var field in search.ProductTable)
							statics[field] = search.ProductTable[field];
						var c = new search.ProductTable;
						for(var field in search.ProductTable.prototype) {
							c[field] = search.ProductTable.prototype[field];
						}
						c.statics = statics;
						return c;
					})());
search.SearchBar = 
					React.createClass((function() {
						var statics = {};
						for(var field in search.SearchBar)
							statics[field] = search.SearchBar[field];
						var c = new search.SearchBar;
						for(var field in search.SearchBar.prototype) {
							c[field] = search.SearchBar.prototype[field];
						}
						c.statics = statics;
						return c;
					})());
App.main();
})();
