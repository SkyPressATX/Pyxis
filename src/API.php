<?php

namespace Pyxis;

/**
 * Main API Class
 *
 * @since 0.1.0
 */
class API
{
    /**
     * Configuration Model
     *
     * @var Pyxis\Model\Config
     */
    public $config;

    /**
     * Class constructor
     *
     * @method __construct
     *
     * @since 0.1.0
     *
     * @param  Pyxis\Model\Config $config
     */
    public function __construct(\Pyxis\Model\Config $config)
    {
        $this->config = $config;
    }
}
