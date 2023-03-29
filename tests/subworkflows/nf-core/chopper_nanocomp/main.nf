#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CHOPPER_NANOCOMP } from '../../../../subworkflows/nf-core/chopper_nanocomp/main.nf'

workflow test_chopper_nanocomp {

    input = [
        [ id:'trimmed' ], // meta map
        file(params.test_data['sarscov2']['nanopore']['test_fastq_gz'], checkIfExists: true),
    ]

    CHOPPER_NANOCOMP ( input )
}
