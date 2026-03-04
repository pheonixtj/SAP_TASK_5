CLASS zcit_internal_table_22am058 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS zcit_internal_table_22am058 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*---------------------------------------------------------
*   Data Declarations
*---------------------------------------------------------
    CONSTANTS car_rent TYPE i VALUE 500.

*---------------------------------------------------------
*   Create Structure
*---------------------------------------------------------
    TYPES: BEGIN OF ty_vehicle,
             vehicle_id    TYPE i,
             vehicle_name  TYPE string,
             vehicle_type  TYPE string,
             rent_per_day  TYPE i,
             availability  TYPE string,
           END OF ty_vehicle.

*---------------------------------------------------------
*   Create Internal Table
*---------------------------------------------------------
    DATA gt_vehicle TYPE STANDARD TABLE OF ty_vehicle.
    DATA gs_vehicle TYPE ty_vehicle.

*---------------------------------------------------------
*   Insert Records
*   ------------------------------------------------------
    gt_vehicle = VALUE #(
      ( vehicle_id = 1 vehicle_name = 'Activa' vehicle_type = 'Two Wheeler'
        rent_per_day = 600 availability = 'Available' )

      ( vehicle_id = 2 vehicle_name = 'Swift' vehicle_type = 'Car'
        rent_per_day = 1500 availability = 'Not Available' )
    ).

out->write( |---------------------------------------------------------| ).
out->write( |Display Table Data| ).
out->write( |---------------------------------------------------------| ).

    LOOP AT gt_vehicle INTO gs_vehicle.

      out->write(
        |ID: { gs_vehicle-vehicle_id } |
        && |Name: { gs_vehicle-vehicle_name } |
        && |Type: { gs_vehicle-vehicle_type } |
        && |Rent: { gs_vehicle-rent_per_day } |
        && |Status: { gs_vehicle-availability }|
      ).
    out->write( |                                           | ).
    out->write( |                                           | ).
    ENDLOOP.

    out->write( |---------------------------------------------------------| ).
    out->write( |Read Table Using Key and Check SY-SUBRC| ).
    out->write( |---------------------------------------------------------| ).
    READ TABLE gt_vehicle INTO gs_vehicle WITH KEY vehicle_id = 1.

    IF sy-subrc = 0.
      out->write( |Vehicle Found: { gs_vehicle-vehicle_name }| ).
      out->write( |                                           | ).
      out->write( |                                           | ).

    ELSE.
      out->write( |Vehicle Not Found| ).
      out->write( |                                           | ).
      out->write( |                                           | ).
    ENDIF.

out->write( |---------------------------------------------------------| ).
out->write( | Insert Internal Table Data into Database| ).
out->write( |---------------------------------------------------------| ).
    DATA ls_db TYPE zcit_vehicle_058.

    LOOP AT gt_vehicle INTO gs_vehicle.

    CLEAR ls_db.

    ls_db-vehicle_id   = gs_vehicle-vehicle_id.
    ls_db-vehicle_name = gs_vehicle-vehicle_name.
    ls_db-vehicle_type = gs_vehicle-vehicle_type.
    ls_db-rent_per_day = gs_vehicle-rent_per_day.
    ls_db-availability = gs_vehicle-availability.

    INSERT zcit_vehicle_058 FROM @ls_db.

    ENDLOOP.

    IF sy-subrc = 0.
       out->write( 'Data inserted into database successfully' ).
    ELSE.
       out->write( 'Error while inserting data' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
