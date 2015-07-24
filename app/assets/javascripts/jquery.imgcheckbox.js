/*
 * imgCheckbox
 *
 * Version: 0.4.0
 * License: GPLv2
 * Author:  James Cuénod
 * Last Modified: 2015.07.08
 *
 */
(function($) {
	var CHK_TOGGLE = 0;
	var CHK_SELECT = 1;
  var CHK_DESELECT = 2;

	var imgCheckboxClass = function(element, options, id) {
		var $wrapperElement, $finalStyles = {}, grayscaleStyles = {
			"span.imgCheckbox img": {
				"transform": "scale(1)",
				"filter": "none",
				"-webkit-filter": "grayscale(0)",
			},
			"span.imgCheckbox.imgChked img": {
				// "filter": "gray", //TODO - this line probably will not work but is necessary for IE
				"filter": "grayscale(1)",
				"-webkit-filter": "grayscale(1)",
			}
		}, scaleStyles = {
			"span.imgCheckbox img": {
				"transform": "scale(1)",
			},
			"span.imgCheckbox.imgChked img": {
				"transform": "scale(0.8)",
			}
		}, scaleCheckMarkStyles = {
			"span.imgCheckbox::before": {
				"transform": "scale(0)",
			},
			"span.imgCheckbox.imgChked::before": {
				"transform": "scale(1)",
			}
		}, fadeCheckMarkStyles = {
			"span.imgCheckbox::before": {
				"opacity": "0",
			},
			"span.imgCheckbox.imgChked::before": {
				"opacity": "1",
			}
		};

		/* *** STYLESHEET STUFF *** */
		// shove in the custom check mark
		if (options.checkMarkImage !== false)
			$.extend(true, $finalStyles, { "span.imgCheckbox::before": { "background-image": "url('" + options.checkMarkImage + "')" }});
		// give the checkmark dimensions
		var chkDimensions = options.checkMarkSize.split(" ");
		$.extend(true, $finalStyles, { "span.imgCheckbox::before": {
			"width": chkDimensions[0],
			"height": chkDimensions[chkDimensions.length - 1]
		}});
		// fixed image sizes
		if (options.fixedImageSize)
		{
			var imgDimensions = options.fixedImageSize.split(" ");
			$.extend(true, $finalStyles,{ "span.imgCheckbox img": {
				"width": imgDimensions[0],
				"height": imgDimensions[imgDimensions.length - 1]
			}});
		}

		var conditionalExtend = [
			{
				doExtension: options.graySelected,
				style: grayscaleStyles
			},
			{
				doExtension: options.scaleSelected,
				style: scaleStyles
			},
			{
				doExtension: options.scaleCheckMark,
				style: scaleCheckMarkStyles
			},
			{
				doExtension: options.fadeCheckMark,
				style: fadeCheckMarkStyles
			}
		];
		conditionalExtend.forEach(function(extension) {
			if (extension.doExtension)
				$.extend(true, $finalStyles, extension.style);
		});

		$finalStyles = $.extend(true, {}, defaultStyles, $finalStyles, options.styles);

		// Now that we've built up our styles, inject them
		injectStylesheet($finalStyles, id);


		/* *** DOM STUFF *** */
		element.wrap("<span class='imgCheckbox" + id + "'>");
		$wrapperElement = element.parent();
		// set up select/deselect functions
		$wrapperElement.each(function(){
			var $that = $(this);
			$(this).data("imgchk.deselect", function(){
				changeSelection($that, CHK_DESELECT, options.addToForm, options.radio, $wrapperElement);
			}).data("imgchk.select", function(){
				changeSelection($that, CHK_SELECT, options.addToForm, options.radio, $wrapperElement);
			});
			$(this).children().first().data("imgchk.deselect", function(){
				changeSelection($that, CHK_DESELECT, options.addToForm, options.radio, $wrapperElement);
			}).data("imgchk.select", function(){
				changeSelection($that, CHK_SELECT, options.addToForm, options.radio, $wrapperElement);
			});
		});
		// preselect elements
		if (options.preselect.length > 0)
		{
			$wrapperElement.each(function(index) {
				if (options.preselect.indexOf(index) >= 0)
					$(this).addClass("imgChked");
			});
		}
		// set up click handler
		$wrapperElement.click(function() {
			changeSelection($(this), CHK_TOGGLE, options.addToForm, options.radio, $wrapperElement);
		});

		/* *** INJECT INTO FORM *** */
	  if (options.addToForm instanceof jQuery || options.addToForm === true)
		{
	    if (options.addToForm === true)
	    {
				options.addToForm = $(element).closest("form");
	    }
			if (options.addToForm.length === 0)
			{
				console.log("imgCheckbox: no form found (looks for form by default)");
				options.addToForm = false;
			}
	  }
		if (options.addToForm !== false)
		{
			$(element).each(function(index) {
				var hiddenElementId = "hEI" + id + "-" + index;
				$(this).parent().data('hiddenElementId', hiddenElementId);
				var imgName = $(this).attr("name");
				imgName = (typeof imgName != "undefined") ? imgName : $(this).attr("src").match(/\/(.*)\.[\w]+$/)[1];
				var imgValue = $(this).attr("value"); /*add yano for biela*/
				$('<input />').attr('type', 'checkbox')
					.attr('name', imgName)
					.attr('value', imgValue)
					.addClass(hiddenElementId)
					.css("display", "none")
					.prop("checked", $(this).parent().hasClass("imgChked"))
					.appendTo(options.addToForm);
			});
		}

		return this;
	};

	/* CSS Injection */
	function injectStylesheet(stylesObject, id)
	{
		// Create a blank style
		var style = document.createElement("style");
		// WebKit hack
		style.appendChild(document.createTextNode(""));
		// Add the <style> element to the page
		document.head.appendChild(style);

		var stylesheet = document.styleSheets[document.styleSheets.length - 1];

		for (var selector in stylesObject){
			if (stylesObject.hasOwnProperty(selector)) {
				compatInsertRule(stylesheet, selector, buildRules(stylesObject[selector]), id);
			}
		}
	}
	function buildRules(ruleObject)
	{
		var ruleSet = "";
		for (var property in ruleObject){
			if (ruleObject.hasOwnProperty(property)) {
				 ruleSet += property + ":" + ruleObject[property] + ";";
			}
		}
		return ruleSet;
	}
	function compatInsertRule(stylesheet, selector, cssText, id)
	{
		var modifiedSelector = selector.replace(".imgCheckbox", ".imgCheckbox" + id);
		// IE8 uses "addRule", everyone else uses "insertRule"
		if (stylesheet.insertRule) {
			stylesheet.insertRule(modifiedSelector + '{' + cssText + '}', 0);
		} else {
			stylesheet.addRule(modifiedSelector, cssText, 0);
		}
	}

	function changeSelection($chosenElement, howToModify, addToForm, radio, $wrapperElement)
	{
		if (radio && howToModify !== CHK_DESELECT)
		{
			$wrapperElement.removeClass("imgChked");
			$chosenElement.addClass("imgChked");
		}
		else
		{
			switch (howToModify) {
				case CHK_DESELECT:
					$chosenElement.removeClass("imgChked");
					break;
				case CHK_TOGGLE:
					$chosenElement.toggleClass("imgChked");
					break;
				case CHK_SELECT:
					$chosenElement.addClass("imgChked");
					break;
			}
		}
		if (addToForm)
			updateFormValues(radio ? $wrapperElement : $chosenElement);
	}
	function updateFormValues($element)
	{
		$element.each(function(){
			$( "." + $(this).data("hiddenElementId") ).prop("checked", $(this).hasClass("imgChked"));
		});
	}


	/* Init */
	$.fn.imgCheckbox = function(options) {
		if ($(this).data("imgCheckboxId"))
			return $.fn.imgCheckbox.instances[$(this).data("imgCheckboxId") - 1];
		else
		{
			var $that = new imgCheckboxClass($(this), $.extend(true, {}, $.fn.imgCheckbox.defaults, options), $.fn.imgCheckbox.instances.length);
			$(this).data("imgCheckboxId", $.fn.imgCheckbox.instances.push($that));
			return $that;
		}
	};
	$.fn.deselect = function() {
		if (this.data("imgchk.deselect"))
		{
			this.data("imgchk.deselect")();
		}
		return this;
	};
	$.fn.select = function() {
		if (this.data("imgchk.select"))
		{
			this.data("imgchk.select")();
		}
		return this;
	};
	$.fn.imgCheckbox.instances = [];
	$.fn.imgCheckbox.defaults = {
		"checkMarkImage": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI2NCIgaGVpZ2h0PSI2NCI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCAtMzQ2LjM4NCkiPjxwYXRoIGZpbGw9IiMxZWM4MWUiIGZpbGwtb3BhY2l0eT0iLjgiIGQ9Ik0zMiAzNDYuNGEzMiAzMiAwIDAgMC0zMiAzMiAzMiAzMiAwIDAgMCAzMiAzMiAzMiAzMiAwIDAgMCAzMi0zMiAzMiAzMiAwIDAgMC0zMi0zMnptMjEuMyAxMC4zbC0yNC41IDQxTDkuNSAzNzVsMTcuNyA5LjYgMjYtMjh6Ii8+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTkuNSAzNzUuMmwxOS4zIDIyLjQgMjQuNS00MS0yNiAyOC4yeiIvPjwvZz48L3N2Zz4=",
		"graySelected": true,
		"scaleSelected": true,
		"fixedImageSize": false,
		"checkMarkSize": "30px",
		"scaleCheckMark": true,
		"fadeCheckMark": false,
		"addToForm": true,
		"preselect": [],
		"radio": false,
	};
	var defaultStyles = {
		"span.imgCheckbox img": {
			"display": "block",
			"margin": "0",
			"padding": "0",
			"transition-duration": "300ms",
		},
		"span.imgCheckbox.imgChked img": {
		},
		"span.imgCheckbox": {
			"user-select": "none",
			"padding": "0",
			"margin": "5px",
			"display": "inline-block",
			"border": "1px solid transparent",
			"transition-duration": "300ms",
		},
		"span.imgCheckbox.imgChked": {
			"border-color": "#ccc",
		},
		"span.imgCheckbox::before": {
			"display": "block",
			"background-size": "100% 100%",
			"content": "''",
			"color": "white",
			"font-weight": "bold",
			"border-radius": "50%",
			"position": "absolute",
			"margin": "0.5%",
			"z-index": "1",
			"text-align": "center",
			"transition-duration": "300ms",
		},
		"span.imgCheckbox.imgChked::before": {
		}
	};

})( jQuery );
