<?php

return (new PhpCsFixer\Config())
    ->setRules([
        '@Symfony' => true,
        'phpdoc_separation' => [
            'groups' => [
                ['ORM\\*'],
            ],
        ],
    ]);

