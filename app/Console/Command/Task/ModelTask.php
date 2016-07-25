<?php
/**
 * Insert Model Task
 *
 * @copyright (c) 2015-present Bolt Softwares Pvt Ltd
 * @licence GNU Affero General Public License http://www.gnu.org/licenses/agpl-3.0.en.html
 */
class ModelTask extends AppShell {

/**
 * Execute the task
 *
 * @return void
 */
	public function execute() {
		$User = ClassRegistry::init('User');
		$user = $User->findByUsername('root@passbolt.com');
		$User->setActive($user);
		$Model = ClassRegistry::init($this->model);

		// Set Db Connection according to what is provided in params.
		if(isset($this->params['connection']) && !empty($this->params['connection'])) {
			$Model->useDbConfig = $this->params['connection'];
		}

		$data = $this->getData();
		foreach ($data as $item) {
			$Model->create();
			$Model->set($item);
			// Get fields to validate. (Sometimes we need exceptions).
			$validationFields = method_exists($this, 'getValidationFields') ? ['fieldList' => $this->getValidationFields($item)] : [];
			if (!$Model->validates($validationFields)) {
				if (!isset($this->params['quiet']) || $this->params['quiet'] != 1) {
					var_dump($Model->validationErrors);
				}
			}
			$instance = $Model->save($item, false);
			if (!$instance) {
				$this->out('<error>Unable to insert ' . pr($item[$this->model]) . '</error>');
				die;
			}
		}
	}

}
