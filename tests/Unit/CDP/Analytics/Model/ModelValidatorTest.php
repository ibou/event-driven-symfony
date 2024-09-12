<?php

declare(strict_types=1);

namespace App\Tests\Unit\CDP\Analytics\Model;

use PHPUnit\Framework\TestCase;

class ModelValidatorTest extends TestCase
{

    private ModelValidator $unit;

    protected function setUp(): void
    {
        $this->unit = new ModelValidator();
        dd($this->unit);
    }
}