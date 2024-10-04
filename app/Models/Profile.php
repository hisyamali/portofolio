<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Support\Facades\Storage;

class Profile extends Model
{
    use HasFactory;

    protected $fillable = [
        'images1',
        'images2',
        'images3',
    ];

    protected $appends = ['image1', 'image2', 'image3'];

    public function getImage1Attribute()
    {
        return Storage::url($this->images1);
    }

    public function getImage2Attribute()
    {
        return Storage::url($this->images2);
    }

    public function getImage3Attribute()
    {
        return Storage::url($this->images3);
    }
}
