
process TENSORFLOW_GPU {
    tag "$meta.id"
    label 'process_gpu'

    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://community-cr-prod.seqera.io/docker/registry/v2/blobs/sha256/26/26e44443247df87b61bfdc04b485767a7a0d8705d7e3ca4533ba6fac10dee72d/data':
        'community.wave.seqera.io/library/pip_tensorflow:0f749bed0a38a835' }"

    input:
    tuple val(meta), path(bam)

    output:
    path "*.gpu.info"          , emit: info
    path "versions.yml"        , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    checkgpu.py > ${prefix}.gpu.info

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        beast: V1.10
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    touch ${prefix}.bam

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        beast: V1.10
    END_VERSIONS
    """

}
