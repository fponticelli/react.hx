package ;

import react.React;

class App extends React
{	
	static function main() 
	{
		React.renderComponent(
			@dom '<App />',
			 js.Browser.document.body
		);
	}
	
	//----------------------------------------------------------------
	
	var greeter = "world";
		
	public function render() 
	{
		return @dom '
			<div>
				<h1>Hello {this.greeter}!</h1>
			</div>
		';
	}	
}




