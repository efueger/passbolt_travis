steal(
	'jquery/model'
).then(function () {

	/*
	 * @class mad.model.Action
	 * @inherits jQuery.Model
	 * @parent mad.controller.component
	 * 
	 * The Action model will carry actions used by other component
	 * 
	 * @constructor
	 * Creates a new Action
	 * @param {array} options
	 * @return {mad.model.Action}
	 */
	$.Model('mad.model.Action', /** @static */ {

		/**
		 * Define attributes of the model
		 * @type {Object}
		 */
		attributes: {
			'id': 'string',
			'label': 'string',
			'icon': 'string',
			'action': 'string'
		}

	}, /** @prototype */ {});

});