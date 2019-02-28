( function _EncoderStrategy_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  var _ = require( '../../Tools.s' );
  require( '../l8/GdfConverter.s' );
  _.include( 'wTesting' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// data
// --

let SamplesPrimitive =
{

  null : null,
  number : 13,
  string : 'something',

}

let SamplesSimple =
{

  map : { a : '1', dir : { b : 2 }, c : [ 1,2,3 ] },
  array : [ { a : '1', dir : { b : 2 }, c : [ 1,2,3 ] } ],

}

let SamplesComplicated =
{

  regexp : /.regexp/g,
  infinity : -Infinity,
  nan : NaN,
  date : new Date(),

}

function Primitive1( test, o )
{
  let samples =
  {
    boolean : true,
    number : 23,
    string : 'something',
  }

  let results = {};

  for( let k in samples )
  {
    test.case = test.name + '.Primitive1: ' + k;
    let src = {};
    src[ k ] = samples[ k ];

    results[ k ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );

      results[ k ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }
  }

  console.log( test.name + '.Primitive1: ', _.toStr( results, { levels : 1 } ) )

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

//

function Primitive2( test, o )
{
  let samples =
  {
    null : null,
    '+infinity' : +Infinity,
    '-infinity' : -Infinity,
    nan : NaN,
  }

  let results = {};

  for( let k in samples )
  {
    test.case = test.name + '.Primitive2: ' + k;
    let src = {};
    src[ k ] = samples[ k ];

    results[ k ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );
      results[ k ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }
  }

  console.log( test.name + '.Primitive2: ', _.toStr( results, { levels : 1 } ))

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

//

function Primitive3( test, o )
{
  let samples =
  {
    '+0' : +0,
    '-0' : -0,
    'undefined' : undefined,
    date : new Date()
  }

  if( typeof BigInt !== 'undefined' )
  samples.bigInt = BigInt( 23 );

  let results = {};

  for( let k in samples )
  {
    test.case = test.name + '.Primitive3: ' + k;
    let src = {};
    src[ k ] = samples[ k ];

    results[ k ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );
      results[ k ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }
  }

  console.log( test.name + '.Primitive3: ', _.toStr( results, { levels : 1 } ))

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

//

function RegExp1( test, o )
{
  let samples =
  {
    1 : /ab|cd/,
    2 : /a[bc]d/,
    3 : /ab{1,}bc/,
    4 : /\.js$/,
    5 : /.regexp/
  }

  let results = {};

  for( let k in samples )
  {
    test.case = test.name + '.RegExp1: ' + samples[ k ].toString();
    let src = {};
    src[ k ] = samples[ k ];

    results[ samples[ k ].toString() ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );

      results[ samples[ k ].toString() ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }
  }

  console.log( test.name + '.RegExp1: ', _.toStr( results, { levels : 1 } ))

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

//

function RegExp2( test, o )
{
  let samples =
  {
    0 : /ab|cd/,
    1 : /a[bc]d/,
    3 : /ab{1,}bc/,
    4 : /.regexp/g,
    5 : /aBc/i,
    6 : /^\d+/gm,
    7 : /^a.*c$/g,
    8 : /[a-z]/m,
    9 : /^[A-Za-z0-9]$/
  }

  let results = {};

  for( let k in samples )
  {
    test.case = test.name + '.RegExp2: ' + samples[ k ].toString();
    let src = {};
    src[ k ] = samples[ k ];

    results[ samples[ k ].toString() ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );

      results[ samples[ k ].toString() ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }
  }

  console.log( test.name + '.RegExp2: ', _.toStr( results, { levels : 1 } ))

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

//

function Buffer1( test, o )
{
  let samples =
  {
    raw : new ArrayBuffer([ 99,100,101 ]),
    bytes : new Uint8Array([ 99,100,101 ]),
  }

  if( typeof Buffer !== 'undefined' )
  samples.node = Buffer.from([ 99,100,101 ]);

  let results = {};
  let positive = 0;

  for( let k in samples )
  {
    test.case = test.name + '.Buffer1: ' + k;
    let src = {};
    src[ k ] = samples[ k ];

    results[ k ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );

      results[ k ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }

    if( results[ k ] )
    positive += 1;
  }

  test.will = 'at least one buffer is supported';
  test.is( positive );

  console.log( test.name + '.Buffer1: ', _.toStr( results, { levels : 1 } ))

  if( !positive )
  return false;

  return true;
}

function Buffer2( test, o )
{
  let samples =
  {
    raw : new ArrayBuffer([ 99,100,101 ]),
  }

  let results = {};
  let positive = 0;

  for( let k in samples )
  {
    test.case = test.name + '.Buffer1: ' + k;
    let src = {};
    src[ k ] = samples[ k ];

    results[ k ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );

      results[ k ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }

    if( results[ k ] )
    positive += 1;
  }

  test.will = 'at least one buffer is supported';
  test.is( positive > 0 );
  test.will = 'buffer raw must be supported';
  test.is( results.raw );

  console.log( test.name + '.Buffer2: ', _.toStr( results, { levels : 1 } ))

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

//

function Buffer3( test, o )
{
  let samples =
  {
    raw : new ArrayBuffer([ 99,100,101 ]),
    bytes : new Uint8Array([ 99,100,101 ]),
  }

  if( typeof Buffer !== 'undefined' )
  samples.node = Buffer.from([ 99,100,101 ]);

  let results = {};
  let positive = 0;

  for( let k in samples )
  {
    test.case = test.name + '.Buffer3: ' + k;
    let src = {};
    src[ k ] = samples[ k ];

    results[ k ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );

      results[ k ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }

    if( results[ k ] )
    positive += 1;
  }

  test.will = 'all buffers must be supported';
  test.is( positive === _.mapOwnKeys( samples ) );

  console.log( test.name + '.Buffer3: ', _.toStr( results, { levels : 1 } ))

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

//

function Complex1( test, o )
{
  let withArray =
  {
    array : [ 'a', 23,  false ],
  }

  let withNestedArray =
  {
    array : [ [ 'a', 23 ], [ [ {}, false ] ] ],
  }

  let withNestedMap =
  {
    map : { a : '1', dir : { b : 2 }, c : { a : { b : 1 } } }
  }

  let withArrayAndMap =
  {
    map : { a : '1', dir : { b : 2 }, c : [ 1,2,3 ] },
    array : [ { a : '1', dir : { b : 2 }, c : [ 1,2,3 ] } ],
  }

  //

  let samples =
  {
    mapWithArray : withArray,
    mapWithNestedArrays : withNestedArray,
    mapWithNestedMaps : withNestedMap,
    mapWithArrayAndMap : withArrayAndMap
  }

  let results = {};

  for( let k in samples )
  {
    test.case = test.name + '.Complex1: ' + k;
    let src = samples[ k ];

    results[ k ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );

      results[ k ] = test.identical( deserialized.data, src );

    }
    catch( err )
    {
      _.errLogOnce( err );
    }
  }

  console.log( test.name + '.Complex1: ', _.toStr( results, { levels : 1 } ))

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

//

function Complex2( test, o )
{
  let recursion =
  {
    map : { a : '1', dir : { b : 2 }, c : [ 1,2,3 ] },
    array : [ { a : '1', dir : { b : 2 }, c : [ 1,2,3 ] } ],
  }
  recursion.self = recursion;

  let samples =
  {
    recursion : recursion,
  }

  let results = {};

  for( let k in samples )
  {
    test.case = test.name + '.Complex2: ' + k;
    let src = samples[ k ];

    results[ k ] = false;

    try
    {
      let serialized = o.serialize.encode({ data : src });
      test.identical( serialized.format, o.serializeFormat );

      let deserialized = o.deserialize.encode({ data : serialized.data });
      test.identical( deserialized.format, o.deserializeFormat );

      results[ k ] = test.identical( deserialized.data, src );
    }
    catch( err )
    {
      _.errLogOnce( err );
    }

  }

  console.log( test.name + '.Complex2: ', _.toStr( results, { levels : 1 } ))

  for( let k in results )
  if( !results[ k ] )
  return false;

  return true;
}

// --
// test
// --

//

function trivial( test )
{
  var self = this;

  /* */

  test.case = 'select';
  var src = 'val : 13';
  var converters = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'cson', default : 1 });
  test.identical( converters.length, 1 );

  /* */

  test.case = 'encode with encoder';
  var dst = converters[ 0 ].encode({ data : src, format : 'string' });
  var expected = { data : { val : 13 }, format : 'structure' }
  test.identical( dst, expected );

  /* */

  test.case = 'encode without encoder';
  var dst = converters[ 0 ].encode({ data : src });
  var expected = { data : { val : 13 }, format : 'structure' }
  test.identical( dst, expected );

}

//

function json( test )
{
  var self = this;

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'json', default : 1 });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  //

  test.case = 'number';
  var data = '1.12345';
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, 1.12345 );

  test.case = 'string';
  var data = '"1.12345"';
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, '1.12345' );

  test.case = 'null';
  var data = 'null';
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, null );

  test.case = 'array';
  var data = '[0, 1, 2]';
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, [ 0,1,2 ] );

  test.case = 'map';
  var data = '{"0": 0, "1": 1, "2": 2}';
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, { 0 : 0, 1 : 1, 2 : 2 } );

  test.case = 'date as string';
  var data = '2019-02-06T14:50:01.641Z"'
  test.shouldThrowErrorSync( () => deserialize.encode({ data : data }) );

  test.case = 'date as map field';
  var data = '{ "date" : "2019-02-06T14:50:01.641Z" }'
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, { date : '2019-02-06T14:50:01.641Z' } );

  test.case = 'map';
  var data = '{ "a" : "1", "dir" : { "b" : 2 }, "c" : [ 1,2,3 ] }';
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, { a : '1', dir : { b : 2 }, c : [ 1,2,3 ] } );

  test.case = 'regexp';
  var data = '/.regexp/g';
  test.shouldThrowErrorSync( () => deserialize.encode({ data : data }) );

  test.case = 'buffer';
  var data = '( new Uint16Array([ 1,2,3 ]) )';
  test.shouldThrowErrorSync( () => deserialize.encode({ data : data }) );

  test.case = 'map';
  var src =
  {
    a :
    {
      1 : 1,
      b :
      {
        2 : 2,
        c :
        {
          3 : 3
        }
      }
    }
  }
  var data = _.toStr( src, { jsonLike : 1 } )
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, src );

  test.case = 'map';
  var src =
  {
    a :
    {
      1 : 1,
      b :
      {
        2 : 2,
        c :
        {
          3 : 3
        }
      }
    }
  }
  var data = _.toStr( src, { jsonLike : 1 } )
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, src );

  test.case = 'array'
  var src =
  [ 0,
    [ 1,
      [ 2,
        [ 3 ]
      ]
    ]
  ]
  var data = _.toStr( src, { jsonLike : 1 } )
  var deserialized = deserialize.encode({ data : data });
  test.identical( deserialized.data, src );

  test.case = 'complicated map with unsupported type';
  var data = _.toStr( SamplesComplicated, { jsonLike : 1 } );
  test.shouldThrowErrorSync( () => deserialize.encode({ data : data }) );

  test.case = 'complicated map, written by json.fine'
  var src =
  {
    string : 'string',
    number : 1,
    array : [ 1, 'string' ],
    date : new Date( Date.UTC( 2018,1,1 ) ),
    map : { string : 'string', number : 1, array : [ 'string', 1 ] }
  }
  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'json.fine' });
  serialize = serialize[ 0 ];
  var serialized = serialize.encode({ data : src });
  var deserialized = deserialize.encode({ data : serialized.data });
  var expected =
  {
    string : 'string',
    number : 1,
    array : [ 1, 'string' ],
    date : new Date( Date.UTC( 2018,1,1 ) ).toJSON(),
    map : { string : 'string', number : 1, array : [ 'string', 1 ] }
  }
  test.identical( deserialized.data, expected );

  test.case = 'complicated map, written by json.min'
  var src =
  {
    string : 'string',
    number : 1,
    array : [ 1, 'string' ],
    date : new Date( Date.UTC( 2018,1,1 ) ),
    map : { string : 'string', number : 1, array : [ 'string', 1 ] }
  }
  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'json.min' });
  serialize = serialize[ 0 ];
  var serialized = serialize.encode({ data : src });
  var deserialized = deserialize.encode({ data : serialized.data });
  var expected =
  {
    string : 'string',
    number : 1,
    array : [ 1, 'string' ],
    date : new Date( Date.UTC( 2018,1,1 ) ).toJSON(),
    map : { string : 'string', number : 1, array : [ 'string', 1 ] }
  }
  test.identical( deserialized.data, expected );
}

//

function jsonFine( test )
{
  var self = this;

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'json', default : 1 });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  /* json.fine */

  test.case = 'select json.fine';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'json.fine' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];
  test.identical( serialize.shortName, 'json.fine' );

  /* */

  test.open( 'simple' );
  for( let s in SamplesSimple )
  {
    test.case = s;
    let src = SamplesSimple[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'simple' );

  /* */

  test.open( 'primitive' );
  for( let s in SamplesPrimitive )
  {
    test.case = s;
    let src = SamplesPrimitive[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'primitive' );

  /* */

  test.open( 'complicated' );

  test.case = 'all complicated together';
  var serialized = serialize.encode({ data : SamplesComplicated });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  test.shouldThrowErrorSync( () => deserialize.encode({ data : serialized.data }) );

  test.case = 'typed array';
  var src = { typed :  new Uint16Array([ 1,2,3 ]) }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  test.shouldThrowErrorSync( () => deserialize.encode({ data : serialized.data }) );

  test.case = 'regexp';
  var src = { regexp :  /.regexp/g }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  test.shouldThrowErrorSync( () => deserialize.encode({ data : serialized.data }) );

  test.case = 'infinity';
  var src = { infinity : -Infinity }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  test.shouldThrowErrorSync( () => deserialize.encode({ data : serialized.data }) );

  test.case = 'NaN';
  var src = { nan : NaN }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  test.shouldThrowErrorSync( () => deserialize.encode({ data : serialized.data }) );

  test.case = 'date';
  var src = { date : new Date() }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  var deserialized = deserialize.encode({ data : serialized.data })
  var expected = { date : src.date.toJSON() }
  test.identical( deserialized.data, expected );

  test.close( 'complicated' );

}

//

function jsonMin( test )
{
  let self = this;

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'json', default : 1 });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  /* json.min */

  test.case = 'select json.min';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'json', default : 1 });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];
  test.identical( serialize.shortName, 'json.min' );

  /* */

  test.open( 'simple' );
  for( let s in SamplesSimple )
  {
    test.case = s;
    let src = SamplesSimple[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'simple' );

  /* */

  test.open( 'primitive' );
  for( let s in SamplesPrimitive )
  {
    test.case = s;
    let src = SamplesPrimitive[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'primitive' );

  /* */

  test.open( 'complicated' );

  test.case = 'all complicated together';
  var serialized = serialize.encode({ data : SamplesComplicated });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  var deserialized = deserialize.encode({ data : serialized.data });
  var expected =
  {
    'regexp' : {},
    'infinity' : null,
    'nan' : null,
    'date' : SamplesComplicated.date.toJSON()
  }
  test.identical( deserialized.data, expected );
  test.identical( deserialized.format, 'structure' );

  test.case = 'typed array';
  var src = { typed :  new Uint16Array([ 1,2,3 ]) }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  var deserialized = deserialize.encode({ data : serialized.data });
  var expected =
  {
    typed : { '0' : 1, '1' : 2, '2' : 3 }
  }
  test.identical( deserialized.data, expected );

  test.case = 'regexp';
  var src = { regexp :  /.regexp/g }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  var deserialized = deserialize.encode({ data : serialized.data });
  var expected =
  {
    regexp : {}
  }
  test.identical( deserialized.data, expected );

  test.case = 'infinity';
  var src = { infinity : -Infinity }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  var deserialized = deserialize.encode({ data : serialized.data });
  var expected =
  {
    infinity : null
  }
  test.identical( deserialized.data, expected );

  test.case = 'NaN';
  var src = { nan : NaN }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  var deserialized = deserialize.encode({ data : serialized.data });
  var expected =
  {
    nan : null
  }
  test.identical( deserialized.data, expected );

  test.case = 'date';
  var src = { date : new Date() }
  var serialized = serialize.encode({ data : src });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );
  var deserialized = deserialize.encode({ data : serialized.data })
  var expected = { date : src.date.toJSON() }
  test.identical( deserialized.data, expected );

  test.close( 'complicated' );

}


//

function cson( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'cson' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'cson' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  /* */

  test.open( 'simple' );
  for( let s in SamplesSimple )
  {
    test.case = s;
    let src = SamplesSimple[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'simple' );

  /* */

  test.open( 'primitive' );
  for( let s in SamplesPrimitive )
  {
    test.case = s;
    let src = SamplesPrimitive[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'primitive' );

  /* */

  test.open( 'complicated' );
  for( let s in SamplesComplicated )
  {
    test.case = s;
    let src = SamplesComplicated[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'complicated' );

  /* */

}

//

function js( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'js' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'js' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  /* */

  test.open( 'simple' );
  for( let s in SamplesSimple )
  {
    test.case = s;
    let src = SamplesSimple[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'simple' );

  /* */

  test.open( 'primitive' );
  for( let s in SamplesPrimitive )
  {
    test.case = s;
    let src = SamplesPrimitive[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'primitive' );

  /* */

  test.open( 'complicated' );
  for( let s in SamplesComplicated )
  {
    test.case = s;
    let src = SamplesComplicated[ s ];

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'complicated' );

  /* */

}

//

function bson( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'buffer.node', ext : 'bson' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'buffer.node', out : 'structure', ext : 'bson' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  /* */

  test.open( 'simple' );
  for( let s in SamplesSimple )
  {
    test.case = s;
    let src = SamplesSimple[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'buffer.node' );
    test.is( _.bufferNodeIs( serialized.data ) );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'simple' );

  test.case = 'all simple together';
  var serialized = serialize.encode({ data : SamplesSimple });
  test.identical( serialized.format, 'buffer.node' );
  test.is( _.bufferNodeIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesSimple );
  test.identical( deserialized.format, 'structure' );

  /* */

  test.open( 'primitive' );
  for( let s in SamplesPrimitive )
  {
    test.case = s;
    let src = SamplesPrimitive[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'buffer.node' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'primitive' );

  test.case = 'all primitive together';
  var serialized = serialize.encode({ data : SamplesPrimitive });
  test.identical( serialized.format, 'buffer.node' );
  test.is( _.bufferNodeIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesPrimitive );
  test.identical( deserialized.format, 'structure' );

  /* */

  test.open( 'complicated' );
  for( let s in SamplesComplicated )
  {
    test.case = s;
    let src = SamplesComplicated[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'buffer.node' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'complicated' );

  test.case = 'all complicated together';
  var serialized = serialize.encode({ data : SamplesComplicated });
  test.identical( serialized.format, 'buffer.node' );
  test.is( _.bufferNodeIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesComplicated );
  test.identical( deserialized.format, 'structure' );

  /* */

}

//

function cbor( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'buffer.node', ext : 'cbor' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'buffer.node', out : 'structure', ext : 'cbor' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  /* */

  test.open( 'simple' );
  for( let s in SamplesSimple )
  {
    test.case = s;
    let src = SamplesSimple[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'buffer.node' );
    test.is( _.bufferNodeIs( serialized.data ) );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'simple' );

  test.case = 'all simple together';
  var serialized = serialize.encode({ data : SamplesSimple });
  test.identical( serialized.format, 'buffer.node' );
  test.is( _.bufferNodeIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesSimple );
  test.identical( deserialized.format, 'structure' );

  /* */

  test.open( 'primitive' );
  for( let s in SamplesPrimitive )
  {
    test.case = s;
    let src = SamplesPrimitive[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'buffer.node' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'primitive' );

  test.case = 'all primitive together';
  var serialized = serialize.encode({ data : SamplesPrimitive });
  test.identical( serialized.format, 'buffer.node' );
  test.is( _.bufferNodeIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesPrimitive );
  test.identical( deserialized.format, 'structure' );

  /* */

  test.open( 'complicated' );
  for( let s in SamplesComplicated )
  {
    test.case = s;
    let src = SamplesComplicated[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'buffer.node' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'complicated' );

  test.case = 'all complicated together';
  var serialized = serialize.encode({ data : SamplesComplicated });
  test.identical( serialized.format, 'buffer.node' );
  test.is( _.bufferNodeIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesComplicated );
  test.identical( deserialized.format, 'structure' );

  /* */

}

//

function yml( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'yml' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'yml' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  /* */

  test.open( 'simple' );
  for( let s in SamplesSimple )
  {
    test.case = s;
    let src = SamplesSimple[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );
    test.is( _.strIs( serialized.data ) );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'simple' );

  test.case = 'all simple together';
  var serialized = serialize.encode({ data : SamplesSimple });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesSimple );
  test.identical( deserialized.format, 'structure' );

  /* */

  test.open( 'primitive' );
  for( let s in SamplesPrimitive )
  {
    test.case = s;
    let src = SamplesPrimitive[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'primitive' );

  test.case = 'all primitive together';
  var serialized = serialize.encode({ data : SamplesPrimitive });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesPrimitive );
  test.identical( deserialized.format, 'structure' );

  /* */

  test.open( 'complicated' );
  for( let s in SamplesComplicated )
  {
    test.case = s;
    let src = SamplesComplicated[ s ];

    if( !_.mapIs( src ) )
    src = { [ s ] : src };

    var serialized = serialize.encode({ data : src });
    test.identical( serialized.format, 'string' );

    var deserialized = deserialize.encode({ data : serialized.data });
    test.identical( deserialized.data, src );
    test.identical( deserialized.format, 'structure' );
  }
  test.close( 'complicated' );

  test.case = 'all complicated together';
  var serialized = serialize.encode({ data : SamplesComplicated });
  test.identical( serialized.format, 'string' );
  test.is( _.strIs( serialized.data ) );

  var deserialized = deserialize.encode({ data : serialized.data });
  test.identical( deserialized.data, SamplesComplicated );
  test.identical( deserialized.format, 'structure' );

  /* */

}

//

function base64( test )
{
  var self = this;

  var src = 'Lorem Ipsum is simply dummy text.';
  var buffer = _.bufferBytesFrom( src );

  test.case = 'buffer.bytes <-> string/base64';

  var serialize = _.Gdf.Select({ in : 'buffer.bytes', out : 'string/base64', ext : 'base64' });
  test.identical( serialize.length, 1 );
  let base64FromBuffer = serialize[ 0 ];

  var serialize = _.Gdf.Select({ out : 'buffer.bytes', in : 'string/base64', ext : 'base64' });
  test.identical( serialize.length, 1 );
  let base64ToBuffer = serialize[ 0 ];

  var converted = base64FromBuffer.encode({ data : buffer });
  test.identical( converted.format, 'string/base64' );
  test.is( _.strIs( converted.data ) );

  var converted = base64ToBuffer.encode({ data : converted.data });
  test.identical( converted.format, 'buffer.bytes' );
  test.is( _.bufferBytesIs( converted.data ) );
  test.identical( converted.data, buffer );

  test.case = 'string/utf8 <-> string/base64';

  var utf8 = _.encode.utf8FromBuffer( buffer );

  var serialize = _.Gdf.Select({ in : 'string/utf8', out : 'string/base64', ext : 'base64', default : 1 });
  test.identical( serialize.length, 1 );
  let base64FromUtf8 = serialize[ 0 ];

  var serialize = _.Gdf.Select({ out : 'string/utf8', in : 'string/base64', ext : 'utf8', default : 1 });
  test.identical( serialize.length, 1 );
  let base64ToUtf8 = serialize[ 0 ];

  var converted = base64FromUtf8.encode({ data : utf8 });
  test.identical( converted.format, 'string/base64' );
  test.is( _.strIs( converted.data ) );

  var converted = base64ToUtf8.encode({ data : converted.data });
  test.identical( converted.format, 'string/utf8' );
  test.is( _.strIs( converted.data ) );
  test.identical( converted.data, utf8 );

}

//

function utf8( test )
{
  var self = this;

  var src = 'Lorem Ipsum is simply dummy text.';
  var buffer = _.bufferBytesFrom( src );

  test.case = 'buffer.bytes <-> string/utf8';

  var serialize = _.Gdf.Select({ in : 'buffer.bytes', out : 'string/utf8', ext : 'utf8' });
  test.identical( serialize.length, 1 );
  let utf8FromBuffer = serialize[ 0 ];

  var serialize = _.Gdf.Select({ out : 'buffer.bytes', in : 'string/utf8', ext : 'bytes' });
  test.identical( serialize.length, 1 );
  let utf8ToBuffer = serialize[ 0 ];

  var converted = utf8FromBuffer.encode({ data : buffer });
  test.identical( converted.format, 'string/utf8' );
  test.is( _.strIs( converted.data ) );

  var converted = utf8ToBuffer.encode({ data : converted.data });
  test.identical( converted.format, 'buffer.bytes' );
  test.is( _.bufferBytesIs( converted.data ) );
  test.identical( converted.data, buffer );
}

//

function jsonFineSupportedTypes( test )
{
  var self = this;

  /* json.fine */

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'json.fine' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];
  test.identical( serialize.shortName, 'json.fine' );

  /* json */

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'json', default : 1 });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  let options =
  {
    serialize : serialize,
    deserialize : deserialize,
    serializeFormat : 'string',
    deserializeFormat : 'structure'
  }

  var gotPrimitive1 = Primitive1( test, options );
  var gotPrimitive2 = Primitive2( test, options );
  var gotPrimitive3 = Primitive3( test, options );
  var gotRegExp1 = RegExp1( test, options );
  var gotRegExp2 = RegExp2( test, options );
  var gotBuffer1 = Buffer1( test, options );
  var gotBuffer2 = Buffer2( test, options );
  var gotBuffer3 = Buffer3( test, options );
  var gotComplex1 = Complex1( test, options );
  var gotComplex2 = Complex2( test, options );


  test.case = 'json.fine supports Primitive1'
  test.is( gotPrimitive1 )
  test.case = 'json.fine supports Primitive2'
  test.is( gotPrimitive2 )
  test.case = 'json.fine supports Primitive3'
  test.is( gotPrimitive3 )
  test.case = 'json.fine supports RegExp1'
  test.is( gotRegExp1 )
  test.case = 'json.fine supports RegExp2'
  test.is( gotRegExp2 )
  test.case = 'json.fine supports Buffer1'
  test.is( gotBuffer1 )
  test.case = 'json.fine supports Buffer2'
  test.is( gotBuffer2 )
  test.case = 'json.fine supports Buffer3'
  test.is( gotBuffer3 )
  test.case = 'json.fine supports Complex1'
  test.is( gotComplex1 )
  test.case = 'json.fine supports Complex2'
  test.is( gotComplex2 )

}

//

function jsonMinSupportedTypes( test )
{
  var self = this;

  /* json.min */

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'json', default : 1 });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];
  test.identical( serialize.shortName, 'json.min' );

  /* json */

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'json', default : 1 });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  let options =
  {
    serialize : serialize,
    deserialize : deserialize,
    serializeFormat : 'string',
    deserializeFormat : 'structure'
  }

  var gotPrimitive1 = Primitive1( test, options );
  var gotPrimitive2 = Primitive2( test, options );
  var gotPrimitive3 = Primitive3( test, options );
  var gotRegExp1 = RegExp1( test, options );
  var gotRegExp2 = RegExp2( test, options );
  var gotBuffer1 = Buffer1( test, options );
  var gotBuffer2 = Buffer2( test, options );
  var gotBuffer3 = Buffer3( test, options );
  var gotComplex1 = Complex1( test, options );
  var gotComplex2 = Complex2( test, options );


  test.case = 'json.min supports Primitive1'
  test.is( gotPrimitive1 )
  test.case = 'json.min supports Primitive2'
  test.is( gotPrimitive2 )
  test.case = 'json.min supports Primitive3'
  test.is( gotPrimitive3 )
  test.case = 'json.min supports RegExp1'
  test.is( gotRegExp1 )
  test.case = 'json.min supports RegExp2'
  test.is( gotRegExp2 )
  test.case = 'json.min supports Buffer1'
  test.is( gotBuffer1 )
  test.case = 'json.min supports Buffer2'
  test.is( gotBuffer2 )
  test.case = 'json.min supports Buffer3'
  test.is( gotBuffer3 )
  test.case = 'json.min supports Complex1'
  test.is( gotComplex1 )
  test.case = 'json.min supports Complex2'
  test.is( gotComplex2 )

}

//

function csonSupportedTypes( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'cson' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'cson' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  let options =
  {
    serialize : serialize,
    deserialize : deserialize,
    serializeFormat : 'string',
    deserializeFormat : 'structure'
  }

  var gotPrimitive1 = Primitive1( test, options );
  var gotPrimitive2 = Primitive2( test, options );
  var gotPrimitive3 = Primitive3( test, options );
  var gotRegExp1 = RegExp1( test, options );
  var gotRegExp2 = RegExp2( test, options );
  var gotBuffer1 = Buffer1( test, options );
  var gotBuffer2 = Buffer2( test, options );
  var gotBuffer3 = Buffer3( test, options );
  var gotComplex1 = Complex1( test, options );
  var gotComplex2 = Complex2( test, options );


  test.case = 'cson supports Primitive1'
  test.is( gotPrimitive1 )
  test.case = 'cson supports Primitive2'
  test.is( gotPrimitive2 )
  test.case = 'cson supports Primitive3'
  test.is( gotPrimitive3 )
  test.case = 'cson supports RegExp1'
  test.is( gotRegExp1 )
  test.case = 'cson supports RegExp2'
  test.is( gotRegExp2 )
  test.case = 'cson supports Buffer1'
  test.is( gotBuffer1 )
  test.case = 'cson supports Buffer2'
  test.is( gotBuffer2 )
  test.case = 'cson supports Buffer3'
  test.is( gotBuffer3 )
  test.case = 'cson supports Complex1'
  test.is( gotComplex1 )
  test.case = 'cson supports Complex2'
  test.is( gotComplex2 )

}

//

function jsSupportedTypes( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'js' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'js' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  let options =
  {
    serialize : serialize,
    deserialize : deserialize,
    serializeFormat : 'string',
    deserializeFormat : 'structure'
  }

  var gotPrimitive1 = Primitive1( test, options );
  var gotPrimitive2 = Primitive2( test, options );
  var gotPrimitive3 = Primitive3( test, options );
  var gotRegExp1 = RegExp1( test, options );
  var gotRegExp2 = RegExp2( test, options );
  var gotBuffer1 = Buffer1( test, options );
  var gotBuffer2 = Buffer2( test, options );
  var gotBuffer3 = Buffer3( test, options );
  var gotComplex1 = Complex1( test, options );
  var gotComplex2 = Complex2( test, options );


  test.case = 'js supports Primitive1'
  test.is( gotPrimitive1 )
  test.case = 'js supports Primitive2'
  test.is( gotPrimitive2 )
  test.case = 'js supports Primitive3'
  test.is( gotPrimitive3 )
  test.case = 'js supports RegExp1'
  test.is( gotRegExp1 )
  test.case = 'js supports RegExp2'
  test.is( gotRegExp2 )
  test.case = 'js supports Buffer1'
  test.is( gotBuffer1 )
  test.case = 'js supports Buffer2'
  test.is( gotBuffer2 )
  test.case = 'js supports Buffer3'
  test.is( gotBuffer3 )
  test.case = 'js supports Complex1'
  test.is( gotComplex1 )
  test.case = 'js supports Complex2'
  test.is( gotComplex2 )

}

//

function bsonSupportedTypes( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'buffer.node', ext : 'bson' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'buffer.node', out : 'structure', ext : 'bson' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  let options =
  {
    serialize : serialize,
    deserialize : deserialize,
    serializeFormat : 'buffer.node',
    deserializeFormat : 'structure'
  }

  var gotPrimitive1 = Primitive1( test, options );
  var gotPrimitive2 = Primitive2( test, options );
  var gotPrimitive3 = Primitive3( test, options );
  var gotRegExp1 = RegExp1( test, options );
  var gotRegExp2 = RegExp2( test, options );
  var gotBuffer1 = Buffer1( test, options );
  var gotBuffer2 = Buffer2( test, options );
  var gotBuffer3 = Buffer3( test, options );
  var gotComplex1 = Complex1( test, options );
  var gotComplex2 = Complex2( test, options );


  test.case = 'bson supports Primitive1'
  test.is( gotPrimitive1 )
  test.case = 'bson supports Primitive2'
  test.is( gotPrimitive2 )
  test.case = 'bson supports Primitive3'
  test.is( gotPrimitive3 )
  test.case = 'bson supports RegExp1'
  test.is( gotRegExp1 )
  test.case = 'bson supports RegExp2'
  test.is( gotRegExp2 )
  test.case = 'bson supports Buffer1'
  test.is( gotBuffer1 )
  test.case = 'bson supports Buffer2'
  test.is( gotBuffer2 )
  test.case = 'bson supports Buffer3'
  test.is( gotBuffer3 )
  test.case = 'bson supports Complex1'
  test.is( gotComplex1 )
  test.case = 'bson supports Complex2'
  test.is( gotComplex2 )

}

//

function cborSupportedTypes( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'buffer.node', ext : 'cbor' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'buffer.node', out : 'structure', ext : 'cbor' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  let options =
  {
    serialize : serialize,
    deserialize : deserialize,
    serializeFormat : 'buffer.node',
    deserializeFormat : 'structure'
  }

  var gotPrimitive1 = Primitive1( test, options );
  var gotPrimitive2 = Primitive2( test, options );
  var gotPrimitive3 = Primitive3( test, options );
  var gotRegExp1 = RegExp1( test, options );
  var gotRegExp2 = RegExp2( test, options );
  var gotBuffer1 = Buffer1( test, options );
  var gotBuffer2 = Buffer2( test, options );
  var gotBuffer3 = Buffer3( test, options );
  var gotComplex1 = Complex1( test, options );
  var gotComplex2 = Complex2( test, options );


  test.case = 'cbor supports Primitive1'
  test.is( gotPrimitive1 )
  test.case = 'cbor supports Primitive2'
  test.is( gotPrimitive2 )
  test.case = 'cbor supports Primitive3'
  test.is( gotPrimitive3 )
  test.case = 'cbor supports RegExp1'
  test.is( gotRegExp1 )
  test.case = 'cbor supports RegExp2'
  test.is( gotRegExp2 )
  test.case = 'cbor supports Buffer1'
  test.is( gotBuffer1 )
  test.case = 'cbor supports Buffer2'
  test.is( gotBuffer2 )
  test.case = 'cbor supports Buffer3'
  test.is( gotBuffer3 )
  test.case = 'cbor supports Complex1'
  test.is( gotComplex1 )
  test.case = 'cbor supports Complex2'
  test.is( gotComplex2 )

}

//

function ymlSupportedTypes( test )
{
  var self = this;

  /* */

  test.case = 'select';

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'yml' });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'yml' });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  let options =
  {
    serialize : serialize,
    deserialize : deserialize,
    serializeFormat : 'string',
    deserializeFormat : 'structure'
  }

  var gotPrimitive1 = Primitive1( test, options );
  var gotPrimitive2 = Primitive2( test, options );
  var gotPrimitive3 = Primitive3( test, options );
  var gotRegExp1 = RegExp1( test, options );
  var gotRegExp2 = RegExp2( test, options );
  var gotBuffer1 = Buffer1( test, options );
  var gotBuffer2 = Buffer2( test, options );
  var gotBuffer3 = Buffer3( test, options );
  var gotComplex1 = Complex1( test, options );
  var gotComplex2 = Complex2( test, options );


  test.case = 'yml supports Primitive1'
  test.is( gotPrimitive1 )
  test.case = 'yml supports Primitive2'
  test.is( gotPrimitive2 )
  test.case = 'yml supports Primitive3'
  test.is( gotPrimitive3 )
  test.case = 'yml supports RegExp1'
  test.is( gotRegExp1 )
  test.case = 'yml supports RegExp2'
  test.is( gotRegExp2 )
  test.case = 'yml supports Buffer1'
  test.is( gotBuffer1 )
  test.case = 'yml supports Buffer2'
  test.is( gotBuffer2 )
  test.case = 'yml supports Buffer3'
  test.is( gotBuffer3 )
  test.case = 'yml supports Complex1'
  test.is( gotComplex1 )
  test.case = 'yml supports Complex2'
  test.is( gotComplex2 )

}

//

function perfomance( test )
{
  let src = require( './asset/generated.s' );
  let times = 10000;

  // /* bson */

  // var serialize = _.Gdf.Select({ in : 'structure', out : 'buffer.node', ext : 'bson' });
  // test.identical( serialize.length, 1 );
  // serialize = serialize[ 0 ];

  // var deserialize = _.Gdf.Select({ in : 'buffer.node', out : 'structure', ext : 'bson' });
  // test.identical( deserialize.length, 1 );
  // deserialize = deserialize[ 0 ];

  // run();

  // /* yaml */

  // var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'yml' });
  // test.identical( serialize.length, 1 );
  // serialize = serialize[ 0 ];

  // var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'yml' });
  // test.identical( deserialize.length, 1 );
  // deserialize = deserialize[ 0 ];

  // run();

  // /* cson */

  // var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'cson' });
  // test.identical( serialize.length, 1 );
  // serialize = serialize[ 0 ];

  // var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'cson' });
  // test.identical( deserialize.length, 1 );
  // deserialize = deserialize[ 0 ];

  // run();

  /* cbor */

  // var serialize = _.Gdf.Select({ in : 'structure', out : 'buffer.node', ext : 'cbor' });
  // test.identical( serialize.length, 1 );
  // serialize = serialize[ 0 ];

  // var deserialize = _.Gdf.Select({ in : 'buffer.node', out : 'structure', ext : 'cbor' });
  // test.identical( deserialize.length, 1 );
  // deserialize = deserialize[ 0 ];

  // run();


  /* js */

  // var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'js' });
  // test.identical( serialize.length, 1 );
  // serialize = serialize[ 0 ];

  // var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'js' });
  // test.identical( deserialize.length, 1 );
  // deserialize = deserialize[ 0 ];

  // run();

  /* json.fine */

  // var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'json.fine' });
  // test.identical( serialize.length, 1 );
  // serialize = serialize[ 0 ];
  // test.identical( serialize.shortName, 'json.fine' );

  // var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'json', default : 1 });
  // test.identical( deserialize.length, 1 );
  // deserialize = deserialize[ 0 ];

  // run();

  /* json.min */

  var serialize = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'json', default : 1 });
  test.identical( serialize.length, 1 );
  serialize = serialize[ 0 ];
  test.identical( serialize.shortName, 'json.min' );

  var deserialize = _.Gdf.Select({ in : 'string', out : 'structure', ext : 'json', default : 1 });
  test.identical( deserialize.length, 1 );
  deserialize = deserialize[ 0 ];

  run();

  /*  */

  function run()
  {
    let serialized;
    let deserialized;

    var t0 = _.timeNow();
    for( let i = 0; i < times; i++ )
    {
      serialized = serialize.encode({ data : src });
    }
    var spent = _.timeSpent( 'write , ' + times + ' times: ' + serialize.name + ' : ', t0 );
    console.log( spent );

    var t0 = _.timeNow();
    for( let i = 0; i < times; i++ )
    {
      deserialized = deserialize.encode({ data : serialized.data });
    }
    var spent = _.timeSpent( 'read , ' + times + ' times: ' + deserialize.name + ' : ', t0 );
    console.log( spent );
  }

}

//

function select( test )
{
  let self = this;

  test.case = 'all'
  var got = _.Gdf.Select({});
  test.is( got.length === _.Gdf.Elements.length );

  test.case = 'in'
  var got = _.Gdf.Select({ in : 'structure' });
  test.is( got.length );

  test.case = 'out'
  var got = _.Gdf.Select({ out : 'string' });
  test.is( got.length );

  test.case = 'not existing'

  var got = _.Gdf.Select({ in : 'not existing'});
  test.is( !got.length );

  var got = _.Gdf.Select({ out : 'not existing'});
  test.is( !got.length );

  var got = _.Gdf.Select({ ext : 'not existing' });
  test.is( !got.length );

  test.case = 'default';

  var got = _.Gdf.Select({ in : 'structure', out : 'string' });
  test.is( got.length > 1 );
  var got = _.Gdf.Select({ in : 'structure', out : 'string', default : 1 });
  test.is( got.length === 1 );
  test.identical( got[ 0 ].shortName, 'json.min' );

  // test.case = 'shortName';

  // var got = _.Gdf.Select({ shortName : 'json.fine', out : 'string' });
  // test.is( got.length === 1 );
  // test.identical( got[ 0 ].shortName, 'json.fine' );

  if( !Config.debug )
  return;

  test.case = 'not supported value'

  test.shouldThrowErrorSync( () => _.Gdf.Select() );
  test.shouldThrowErrorSync( () => _.Gdf.Select({ ext : [ 'json.fine', 'json' ] }) );

}

//

function register( test )
{
  let self = this;

  var converter =
  {
    ext : [ 'ext' ],
    in : [ 'string' ],
    out : [ 'number' ],

    onEncode : function( op )
    {
      _.assert( _.strIs( op.in.data ) );
      op.out.data = Number.parseFloat( op.in.data );
      op.out.format = 'number';
    }
  }

  converter = _.Gdf( converter );

  test.is( _.arrayHas( _.Gdf.Elements, converter ) );
  test.is( _.arrayHas( _.Gdf.InMap[ 'string' ], converter ) );
  test.is( _.arrayHas( _.Gdf.OutMap[ 'number' ], converter ) );
  test.is( _.arrayHas( _.Gdf.ExtMap[ 'ext' ], converter ) );
  test.is( _.arrayHas( _.Gdf.InOutMap[ 'string-number' ], converter ) );

  converter.finit();

  test.is( !_.arrayHas( _.Gdf.Elements, converter ) );
  test.is( !_.arrayHas( _.Gdf.InMap[ 'string' ], converter ) );
  test.is( !_.arrayHas( _.Gdf.OutMap[ 'number' ], converter ) );
  test.is( !_.arrayHas( _.Gdf.ExtMap[ 'ext' ], converter ) );
  test.is( !_.arrayHas( _.Gdf.InOutMap[ 'string-number' ], converter ) );
}

//

function finit( test )
{
  let self = this;

  var encoder = _.Gdf.Select({ in : 'structure', out : 'string', ext : 'yml' });
  test.identical( encoder.length, 1 );
  encoder = encoder[ 0 ].encoder;
  test.identical( encoder.inOut, [ 'structure-string' ] )

  test.is( _.arrayHas( _.Gdf.Elements, encoder ) );
  test.is( _.arrayHas( _.Gdf.InMap[ 'structure' ], encoder ) );
  test.is( _.arrayHas( _.Gdf.OutMap[ 'string' ], encoder ) );
  test.is( _.arrayHas( _.Gdf.ExtMap[ 'yml' ], encoder ) );
  test.is( _.arrayHas( _.Gdf.InOutMap[ 'structure-string' ], encoder ) );

  encoder.finit();

  test.is( !_.arrayHas( _.Gdf.Elements, encoder ) );
  test.is( !_.arrayHas( _.Gdf.InMap[ 'structure' ], encoder ) );
  test.is( !_.arrayHas( _.Gdf.OutMap[ 'string' ], encoder ) );
  test.is( !_.arrayHas( _.Gdf.ExtMap[ 'yml' ], encoder ) );
  test.is( !_.arrayHas( _.Gdf.InOutMap[ 'structure-string' ], encoder ) );
}

// --
// declare
// --

var Self =
{

  name : 'Tools/base/EncoderStrategy',
  silencing : 1,

  tests :
  {
    trivial,
    jsonFine,
    jsonMin,
    json,
    cson,
    js,
    bson,
    cbor,
    yml,

    base64,
    utf8,

    //

    // jsonFineSupportedTypes,
    // jsonMinSupportedTypes,
    // csonSupportedTypes,
    // jsSupportedTypes,
    // bsonSupportedTypes,
    // cborSupportedTypes,
    // ymlSupportedTypes,

    //

    // perfomance,

    //

    select,
    register,
    finit
  },

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();